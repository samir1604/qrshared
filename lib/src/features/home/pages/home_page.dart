import 'package:flutter/material.dart';
import 'package:qr_shared_app/src/core/constants/asset_constants.dart';
import 'package:qr_shared_app/src/core/constants/string_constants.dart';
import 'package:qr_shared_app/src/core/extensions/extensions.dart';

import 'package:qr_shared_app/src/core/injector.dart';
import 'package:qr_shared_app/src/features/home/widgets/info_content.dart';
import 'package:qr_shared_app/src/features/home/widgets/scan_qr_button.dart';
import 'package:qr_shared_app/src/features/paid_on_line/pages/scanner_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue.shade900, Colors.blue.shade100],
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: context.systemTopPadding + context.spacingLarge,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: context.isSmallWidth
                            ? context.getSize.width * .5
                            : context.getSize.width * .7,
                        child: Image.asset(AssetConstants.logo),
                      ),
                      SizedBox(height: context.spacingMedium),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            StringConstants.sharedQr,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.1,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: context.spacingSmall),
                      Text(
                        StringConstants.quickPaid,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: .8),
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: context.isSmallWidth ? 30 : 60),
                      ScanQrButton(
                        onTap: () => _navigateToScanner(context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: context.systemTopPadding + 10,
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
