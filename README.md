# QR Shared

**QR Shared** es una herramienta ligera y eficiente diseñada para simplificar el proceso de pagos y transferencias en Cuba. Actúa como un puente inteligente entre códigos QR y la plataforma **Transfermóvil**, eliminando errores manuales y agilizando la experiencia del usuario.



## Características

- **Escaneo Inteligente:** Detecta automáticamente si el QR corresponde a un Pago en Línea o a una Transferencia.
- **Detección de Bancos:** Identifica visualmente si la tarjeta es de **BANDEC, BPA o Banco Metropolitano** mediante el análisis del BIN.
- **Integración Directa:** Abre automáticamente el módulo de Pago en Línea en Transfermóvil con los datos pre-completados.
- **Gestión de Transferencias:** Facilita la copia de números de tarjeta y teléfonos para transferencias manuales.
- **Soporte de Galería:** ¿Tienes el QR en una foto? Súbelo directamente desde la galería.
- **Optimización de Lectura:** Incluye soporte para linterna en condiciones de baja luz.

## Arquitectura y Tecnologías

El proyecto sigue el patrón de diseño **MVVM (Model-View-ViewModel)** para separar la lógica de negocio de la interfaz de usuario, garantizando un código mantenible y escalable.

- **Lenguaje:** [Dart](https://dart.dev/)
- **Framework:** [Flutter](https://flutter.dev/)
- **Gestión de Estado:** `ValueNotifier` y `ValueListenableBuilder` para una reactividad quirúrgica y eficiente.
- **Plugins principales:**
    - `mobile_scanner`: Para una lectura de QR rápida y precisa.
    - `url_launcher`: Para la integración con apps externas y soporte técnico.

## Instalación y Compilación

Para clonar y ejecutar esta aplicación, necesitarás [Git](https://git-scm.com) y [Flutter](https://docs.flutter.dev/get-started/install) instalados en tu equipo.

```bash
# Clonar el repositorio
git clone [https://github.com/samir1604/qrshared.git]

# Entrar en la carpeta
cd qr_shared_app

# Instalar dependencias
flutter pub get

# Ejecutar la aplicación
flutter run
```

## Licencia

Este proyecto está bajo la Licencia MIT. Consulta el archivo [LICENSE](LICENSE) para más detalles.

## Descargo de Responsabilidad

Esta aplicación es una herramienta independiente y **no está afiliada, asociada, autorizada ni respaldada** por ETECSA o las instituciones bancarias de Cuba. El nombre Transfermóvil es una marca registrada de sus respectivos dueños. Úsala bajo tu propia responsabilidad.
