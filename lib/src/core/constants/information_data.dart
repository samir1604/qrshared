import 'package:qr_shared_app/src/core/models/info_data.dart';

class InformationContent {
  InformationContent._();

  static List<InfoData> sections = [
    InfoData(
      'Problema',
      'Recientemente, en la nueva versión de Transfermóvil, el escáner '
          'de QR ha presentado fallas, especialmente en la sección de pago en '
          'línea. Tras verificar, se observó que el problema no radica solo en '
          'el estado físico de los códigos QR. Aunque la última versión de '
          'Transfermóvil permite habilitar un escáner alternativo desde el '
          'menú de configuración, para muchos usuarios esta opción sigue sin '
          'funcionar correctamente.',
    ),
    InfoData(
      'Propósito',
      'Esta aplicación simplifica el proceso al enfocarse exclusivamente en los módulos de pago en línea y transferencias. El escáner incluye soporte para linterna en condiciones de baja iluminación y permite subir fotos de códigos QR directamente desde tu galería para que la aplicación las analice automáticamente.',
    ),
    InfoData(
      'Módulo Pago en Línea',
      'Al escanear un código, la aplicación detectará automáticamente si se trata de un pago en línea. Si es así, abrirá directamente Transfermóvil en la sección correspondiente, completando los datos necesarios para que solo tengas que confirmar la operación como lo haces habitualmente.',
    ),
    InfoData(
      'Módulo Transferencia',
      'Debido a restricciones técnicas de Transfermóvil, los datos de transferencia no se pueden autocompletar. Por ello, nuestra aplicación te facilita el número de tarjeta y teléfono de destino de forma visible y fácil de copiar. Estamos trabajando para automatizar este paso en futuras actualizaciones según lo permitan las nuevas versiones de la plataforma oficial.',
    ),
    InfoData(
      'Feedback',
      'Esta aplicación se encuentra en fase de desarrollo y su opinión es vital. Si tienes sugerencias, deseas reportar un error o simplemente quieres compartir si te fue de utilidad, por favor envíanos un comentario indicando el modelo de tu teléfono y el problema detectado. Esperamos que esta herramienta te facilite tus pagos diarios.',
    ),
  ];
}
