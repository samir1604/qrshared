import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_shared_app/src/core/constants/constants.dart';
import 'package:qr_shared_app/src/core/domain/entities/qr_type.dart';
import 'package:qr_shared_app/src/core/extensions/extensions.dart';
import 'package:qr_shared_app/src/core/injector.dart';
import 'package:qr_shared_app/src/core/services/services.dart';
import 'package:qr_shared_app/src/features/paid_on_line/paid_on_line.dart';

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
  String? _qrErrorMessage;
  StreamSubscription<Object>? _subscription;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    _controller = MobileScannerController(
      formats: [BarcodeFormat.qrCode],
      autoStart: false,
    );

    _subscription = _controller.barcodes.listen(_handleDetection);
    unawaited(_controller.start());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(StringConstants.scannerPageTitle),
        backgroundColor: Colors.blue.shade900,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final scanRect = _calculateRec(context, constraints);

          return ValueListenableBuilder(
            valueListenable: _controller,
            builder: (context, state, child) {
              if (_qrErrorMessage != null) {
                return ScannerError(
                  message: _qrErrorMessage!,
                  onPressed: _resetForNewScan,
                );
              }

              return Stack(
                children: [
                  MobileScanner(
                    scanWindow: scanRect,
                    controller: _controller,
                    errorBuilder: (context, scannerError) {
                      final message = !state.hasCameraPermission
                          ? StringConstants.cameraPermissionError
                          : StringConstants.cameraAccessError;

                      return ScannerError(
                        message: message,
                        isCameraError: true,
                        onPressed: () => _controller.start(),
                      );
                    },
                  ),
                  if (state.error == null)
                    IgnorePointer(
                      child: Stack(
                        children: [ScannerOverlay(scanRect: scanRect)],
                      ),
                    ),
                  if (state.error == null)
                    RepaintBoundary(
                      child: ScannerControls(
                        isTorchOn: state.torchState == TorchState.unavailable
                            ? null
                            : state.torchState == TorchState.on,
                        onTorchClick: () => _controller.toggleTorch(),
                        onGalleryClick: _scanFromGallery,
                      ),
                    ),
                  if (!state.isInitialized) const LoadingIndicator(),
                ],
              );
            },
          );
        },
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
    } else {
      setState(() {
        _qrErrorMessage = 'Código QR no válido o no soportado.';
      });
    }
  }

  void _resetForNewScan() {
    setState(() {
      _qrErrorMessage = null;
      _isProcessing = false;
    });
    unawaited(_controller.start());
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

  Rect _calculateRec(BuildContext context, BoxConstraints constraints) {
    final visorSize = (constraints.biggest.shortestSide * .6).clamp(
      200.0,
      280.0,
    );

    final center = Offset(
      constraints.maxWidth / 2,
      (constraints.maxHeight - context.systemBottomPadding) / 2,
    );
    return Rect.fromCenter(center: center, width: visorSize, height: visorSize);
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (!_controller.value.hasCameraPermission ||
        !_controller.value.isInitialized) {
      return;
    }

    switch (state) {
      case AppLifecycleState.resumed:
        _subscription = _controller.barcodes.listen(_handleDetection);
        unawaited(_controller.start());

      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        return;

      case AppLifecycleState.inactive:
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(_controller.stop());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_subscription?.cancel());
    _subscription = null;
    unawaited(_controller.dispose());
    super.dispose();
  }
}
