import 'dart:async';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_shared_app/src/core/constants/constants.dart';
import 'package:qr_shared_app/src/core/extensions/extensions.dart';
import 'package:qr_shared_app/src/core/injector.dart';
import 'package:qr_shared_app/src/core/services/services.dart';
import 'package:qr_shared_app/src/features/paid_on_line/widgets/image_button.dart';
import 'package:qr_shared_app/src/features/paid_on_line/widgets/information_text.dart';
import 'package:qr_shared_app/src/features/paid_on_line/widgets/loading_indicator.dart';
import 'package:qr_shared_app/src/features/paid_on_line/widgets/scanner_overlay.dart';
import 'package:qr_shared_app/src/features/paid_on_line/widgets/torch_button.dart';
import 'package:qr_shared_app/src/features/transfer/pages/transfer_page.dart';
import 'package:vibration/vibration.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({required this.transfer, super.key});

  final TransferService transfer;

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> with WidgetsBindingObserver {
  late final MobileScannerController _controller;
  bool _isProcessing = false;
  Rect? _cachedScanRect;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller = MobileScannerController(
      formats: [BarcodeFormat.qrCode],
    );
  }

  @override
  Widget build(BuildContext context) {
    final scanRect = _cachedScanRect ?? Rect.zero;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text(StringConstants.scannerPageTitle)),
      body: Stack(
        children: [
          MobileScanner(
            scanWindow: scanRect,
            controller: _controller,
            onDetect: _handleDetection,
          ),
          IgnorePointer(
            child: Stack(children: [ScannerOverlay(scanRect: scanRect)]),
          ),
          RepaintBoundary(
            child: ValueListenableBuilder(
              valueListenable: _controller,
              builder: (context, state, child) {
                final isReady = state.isInitialized || state.isRunning;
                final isTouchUnavailable =
                    state.torchState == TorchState.unavailable;
                final isTorchOn = state.torchState == TorchState.on;

                return Stack(
                  children: [
                    Positioned(
                      top: context.systemTopPadding + context.spacingMedium,
                      left: 20,
                      child: ImageButton(onPressed: _scanFromGallery),
                    ),
                    Positioned(
                      bottom: context.systemTopPadding + context.spacingMedium,
                      left: 24,
                      right: 24,
                      child: SafeArea(
                        child: InformationText(
                          text: StringConstants.scanText,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: 20,
                      child: CircleAvatar(
                        backgroundColor: Colors.black.withValues(alpha: .5),
                        child: TorchButton(
                          isOn: isTouchUnavailable ? null : isTorchOn,
                          onPressed: () => _controller.toggleTorch(),
                        ),
                      ),
                    ),
                    if (!isReady) const LoadingIndicator(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleDetection(BarcodeCapture capture) async {
    if (_isProcessing || !mounted) return;

    final barcode = capture.barcodes.firstOrNull;
    if (barcode?.rawValue == null) return;

    _isProcessing = true;
    if (await Vibration.hasVibrator()) {
      await Vibration.vibrate(duration: 80);
    }
    await _controller.stop();
    if (!mounted) return;

    final code = barcode!.rawValue!;
    final type = widget.transfer.identifyQR(code);

    if (type == QRType.payment) {
      await widget.transfer.sendPayment(code);
      if (mounted) {
        Navigator.of(context).pop();
      }
    } else if (type == QRType.transfer) {
      if (!mounted) return;
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
          builder: (_) => TransferPage(
            rawData: code,
            service: di(),
          ),
        ),
      );
    }

    if (mounted) {
      _isProcessing = false;
      await _controller.start();
    }
  }

  Future<void> _scanFromGallery() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    try {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      final model = androidInfo.model.toUpperCase();
      final isNote10 = model.contains('MK2101K7') || model.contains('NOTE 10');
      var pathToAnalyze = image.path;

      if (isNote10) {
        final tempDir = await getTemporaryDirectory();
        final targetPath =
            '${tempDir.path}/fixed_note10_${DateTime.now().millisecondsSinceEpoch}.jpg';

        final fixedImage = await FlutterImageCompress.compressAndGetFile(
          image.path,
          targetPath,
          quality: 100,
        );

        if (fixedImage != null) {
          pathToAnalyze = fixedImage.path;
        }
      }

      final barCode = await _controller.analyzeImage(pathToAnalyze);

      if (barCode != null) {
        await _handleDetection(barCode);
      } else {
        SnackbarService.show(StringConstants.notFoundQr);
      }
    } on Exception catch (_) {
      SnackbarService.show('Error procesando imagen');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final visorSize = (context.effectiveWidth * .7).clamp(200.0, 280.0);
    final appBarHeight = AppBar().preferredSize.height;

    setState(
      () => _cachedScanRect = Rect.fromCenter(
        center: context.getCenterOfBody(appBarHeight),
        width: visorSize,
        height: visorSize,
      ),
    );
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (!_controller.value.hasCameraPermission ||
        !_controller.value.isInitialized) {
      return;
    }

    switch (state) {
      case AppLifecycleState.resumed:
        if (!_controller.value.isRunning) {
          await _controller.start();
        }
        return;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        if (_controller.value.isRunning) {
          await _controller.stop();
        }
        return;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_controller.dispose());
    super.dispose();
  }
}
