

import 'package:qr_shared_app/src/core/constants/constants.dart';

enum BankType { bandec, bpa, metropolitan, unknow }

class TransferData {
  TransferData({
    required this.card,
    required this.phone,
  });

  factory TransferData.fromRaw(String raw) {
    final rawParts = raw.split(',');

    return TransferData(
      card: rawParts.length > 2 ? rawParts[2] : '9876543210123456',
      phone: rawParts.length > 3 ? rawParts[3] : '55555555',
    );
  }

  final String card;
  final String phone;

  BankType get cardType {
    return _getCardType(card);
  }

  String get bankName => switch (cardType) {
    BankType.bandec => StringConstants.bandecString,
    BankType.metropolitan => StringConstants.metropolitanString,
    BankType.bpa => StringConstants.bpaString,
    _ => StringConstants.unknownString,
  };

  static BankType _getCardType(String card) {
    final pair = card.substring(4, 6);
    return switch (pair) {
      '06' => BankType.bandec,
      '95' => BankType.metropolitan, //05
      '12' => BankType.bpa,
      _ => BankType.unknow,
    };
  }

  String get assetImage => switch (cardType) {
    BankType.bandec => AssetConstants.cardBandec,
    BankType.bpa => AssetConstants.cardBpa,
    BankType.metropolitan => AssetConstants.metropolitanCard,
    _ => AssetConstants.cardUnknown,
  };
}
