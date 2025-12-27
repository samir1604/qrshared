import 'package:flutter/material.dart';
import 'package:qr_shared_app/src/core/constants/asset_constants.dart';
import 'package:qr_shared_app/src/core/constants/string_constants.dart';

import 'package:qr_shared_app/src/core/injector.dart';
import 'package:qr_shared_app/src/features/home/widgets/info_content.dart';
import 'package:qr_shared_app/src/features/paid_on_line/pages/scanner_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue.shade900, Colors.blue.shade700],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icono o Logo de la App
                Image.asset(AssetConstants.logo, width: 300),
                const SizedBox(height: 20),
                Text(
                  StringConstants.sharedQr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  StringConstants.quickPaid,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: .8),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 60),
                GestureDetector(
                  onTap: () => _navigateToScanner(context),
                  child: Container(
                    width: size.width * 0.6,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: .2),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt, color: Colors.blue.shade900),
                        const SizedBox(width: 12),
                        Text(
                          StringConstants.scanQr,
                          style: TextStyle(
                            color: Colors.blue.shade900,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              onPressed: () => _showInfoModal(context),
              icon: const Icon(
                Icons.help_outline_rounded,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showInfoModal(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const InfoContent(),
    );
  }

  Future<void> _navigateToScanner(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => ScannerPage(transfer: di()),
      ),
    );
  }
}
