import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
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
                      top: 20,
                      left: 20,
                      child: ImageButton(onPressed: _scanFromGallery),
                    ),
                    Positioned(
                      bottom: 32,
                      left: 24,
                      right: 24,
                      child: InformationText(
                        text: StringConstants.scanText,
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
    if (_isProcessing) return;

    final barcode = capture.barcodes.firstOrNull;
    if (barcode?.rawValue == null) return;

    _isProcessing = true;
    if (await Vibration.hasVibrator()) {
      await Vibration.vibrate(duration: 80);
    }
    await _controller.stop();

    final code = barcode!.rawValue!;
    final type = widget.transfer.identifyQR(code);

    if (type == QRType.payment) {
      await widget.transfer.sendPayment(code);
      if (!mounted) return;
      Navigator.of(context).pop();
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

    final barCode = await _controller.analyzeImage(image.path);

    if (barCode != null) {
      await _handleDetection(barCode);
      return;
    }
    SnackbarService.show(StringConstants.notFoundQr);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_cachedScanRect == null) {
      final appBarHeight = AppBar().preferredSize.height;
      _cachedScanRect = Rect.fromCenter(
        center: context.getCenterOfBody(appBarHeight),
        width: 260,
        height: 260,
      );
    }
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
