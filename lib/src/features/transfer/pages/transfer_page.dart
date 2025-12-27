import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_shared_app/src/core/constants/constants.dart';
import 'package:qr_shared_app/src/core/extensions/extensions.dart';

import 'package:qr_shared_app/src/core/models/models.dart';
import 'package:qr_shared_app/src/core/services/services.dart';
import 'package:qr_shared_app/src/features/transfer/widgets/card_image.dart';
import 'package:qr_shared_app/src/features/transfer/widgets/data_card.dart';

class TransferPage extends StatelessWidget {
  const TransferPage({required this.rawData, required this.service, super.key});

  final String rawData;
  final TransferService service;

  @override
  Widget build(BuildContext context) {
    final cardWidth = context.getSize.width * .60;

    final data = TransferData.fromRaw(rawData);

    return Scaffold(
      appBar: AppBar(title: Text(StringConstants.transferDetail)),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [.08, .4],
            colors: [Colors.blue.shade900, Colors.white],
          ),
        ),
        child: Column(
          children: [
            CardImage(
              assetImage: data.assetImage,
              width: cardWidth,
            ),
            const SizedBox(height: 16),
            Text(
              data.bankName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 40),
            DataCard(
              title: StringConstants.cardNumber,
              value: data.card.toCardFormat(),
              icon: Icons.credit_card,
              onCopy: () => _copyToClipboard(context, data.card),
            ),
            const SizedBox(height: 20),
            DataCard(
              title: StringConstants.phoneNumber,
              value: data.phone,
              icon: Icons.phone_android,
              onCopy: () => _copyToClipboard(context, data.phone),
            ),
            const Spacer(),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.blue.shade800,
                foregroundColor: Colors.white,
              ),
              onPressed: service.openTransfer,
              icon: const Icon(Icons.launch),
              label: Text(StringConstants.openTransfermovil),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _copyToClipboard(
    BuildContext context,
    String message,
  ) async {
    await Clipboard.setData(ClipboardData(text: message));
    SnackbarService.show(MessageConstants.dataCopied);
  }
}
