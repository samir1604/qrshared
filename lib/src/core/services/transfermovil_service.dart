import 'package:android_intent_plus/android_intent.dart';

enum QRType { payment, transfer, unknown }

abstract interface class TransferService {
  QRType identifyQR(String rawValue);

  Future<void> sendPayment(String jsonQR);

  Future<void> openTransfer();
}

class TransferServiceImpl implements TransferService {
  @override
  QRType identifyQR(String rawValue) {
    if (rawValue.contains('id_transaccion') &&
        rawValue.contains('numero_proveedor')) {
      return QRType.payment;
    } else if (rawValue.startsWith('TRANSFERMOVIL_ETECSA')) {
      return QRType.transfer;
    }
    return QRType.unknown;
  }

  @override
  Future<void> sendPayment(String jsonQR) async {
    final intent = AndroidIntent(
      action: 'android.intent.action.SEND',
      package: 'cu.etecsa.cubacel.tr.tm',
      componentName: 'cu.etecsa.cubacel.tr.tm.UIBrjeXVHD',
      type: 'text/plain',
      arguments: {'android.intent.extra.TEXT': jsonQR},
      flags: [0x10000000], // FLAG_ACTIVITY_NEW_TASK
    );

    await intent.launch();
  }

  @override
  Future<void> openTransfer() async {
    const intent = AndroidIntent(
      action: 'android.intent.action.VIEW',
      package: 'cu.etecsa.cubacel.tr.tm',
      componentName: 'cu.etecsa.cubacel.tr.tm.UIBrjeXVHD',
      category: 'android.intent.category.BROWSABLE',
      flags: [
        0x10000000, // FLAG_ACTIVITY_NEW_TASK
        0x04000000, // FLAG_ACTIVITY_CLEAR_TOP
      ],
    );

    await intent.launch();
  }
}
