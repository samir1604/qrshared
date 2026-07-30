# Documento de Requerimientos - Aplicación QR Shared

## 1. Modelo de Datos (PaymentCard)

El modelo de datos central de la aplicación es **PaymentCard**. Este modelo se utilizará para almacenar localmente las tarjetas utilizando la base de datos `hive_ce`, optimizando las búsquedas y el acceso rápido en memoria.

### 1.1 Campos del Modelo

| Campo | Tipo | Requerido | Descripción |
| :--- | :--- | :---: | :--- |
| `qrCode` | `String` | **Sí** | El texto o JSON que contiene el código QR escaneado (necesario para el Intent). |
| `cardName` | `String` | **Sí** | Nombre de la tarjeta (usualmente provisto por el establecimiento). |
| `cardNumber` | `String` | **Sí** | Número identificador de la tarjeta o cuenta. |
| `alias` | `String?` | No | Nombre personalizado por el usuario para recordar fácilmente la tarjeta. |
| `phone` | `String?` | No | Número telefónico asociado al establecimiento (requerido por algunos). |
| `address` | `String?` | No | Dirección del establecimiento (uso recordatorio). |
| `notes`| `String?` | No | Notas adicionales sobre el establecimiento o la tarjeta. |

---

## 2. Interfaz de Usuario (UI) y Funcionalidad

La pantalla principal de gestión de tarjetas (Features: `cards`) deberá cumplir con las siguientes especificaciones:

### 2.1 Componentes Principales
- **Barra de Búsqueda (Buscador):** 
  - Un campo de texto en la parte superior.
  - Al escribir, debe filtrar en tiempo real (usando el estado de `Signals`) la lista de tarjetas almacenadas buscando coincidencias en los campos `alias` y `cardName`.
- **Listado de Tarjetas:**
  - Una lista (ej. `ListView.builder`) que renderice visualmente las tarjetas filtradas.
- **Acciones Rápidas de Pago:**
  - Cada elemento de la lista debe tener un acceso rápido (ej. un botón prominente de "Pagar" o "Enviar").
  - Al presionarlo, se debe enviar el `qrCode` al manejador `PaymentService` (con su implementación `TransfermovilService`).

---

## 3. Consideraciones Técnicas

- **Plataforma**: La aplicación está estrictamente restringida a **Android**, dado que depende de intents nativos para la app Transfermóvil.
- **Gestión de Estado**: Toda la reactividad de la UI (como la búsqueda en tiempo real) debe ser controlada mediante `Signals` y dependencias inyectadas con `get_it`.
- **Estilos**: Respetar las guías definidas en `AGENTS.md` apoyándose estrictamente en el `Theme.of(context)`. No usar colores predefinidos (hardcoded).
- **Formatos de QR**: El agente asume que el sistema de lectura (`mobile_scanner`) extrae el texto puro y que `TransfermovilService` gestiona internamente la validación y el envío del `Intent` a Android.
