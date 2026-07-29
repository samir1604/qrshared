# Documento de Requerimientos - Aplicación QR Shared

## 1. Modelo de Datos (Tarjetas de Pago)

El modelo de datos central de la aplicación es la **Tarjeta de Pago**. Este modelo se utilizará para almacenar localmente las tarjetas utilizando la base de datos `hive` (o `hive_ce`), optimizando las búsquedas y el acceso rápido en memoria.

### 1.1 Campos del Modelo

| Campo | Tipo | Requerido | Descripción |
| :--- | :--- | :---: | :--- |
| `qrCode` | `String` | **Sí** | El texto o JSON que contiene el código QR escaneado (necesario para el Intent). |
| `nombreTarjeta` | `String` | **Sí** | Nombre de la tarjeta (usualmente provisto por el establecimiento). |
| `numeroTarjeta` | `String` | **Sí** | Número identificador de la tarjeta o cuenta. |
| `alias` | `String?` | No | Nombre personalizado por el usuario para recordar fácilmente la tarjeta. |
| `telefono` | `String?` | No | Número telefónico asociado al establecimiento (requerido por algunos). |
| `direccion` | `String?` | No | Dirección del establecimiento (uso recordatorio). |
| `observaciones`| `String?` | No | Notas adicionales sobre el establecimiento o la tarjeta. |

---

## 2. Interfaz de Usuario (UI) y Funcionalidad

La pantalla principal de gestión de tarjetas (Features: `cards` o `tarjetas`) deberá cumplir con las siguientes especificaciones:

### 2.1 Componentes Principales
- **Barra de Búsqueda (Buscador):** 
  - Un campo de texto en la parte superior.
  - Al escribir, debe filtrar en tiempo real (usando el estado de `Signals`) la lista de tarjetas almacenadas buscando coincidencias en los campos `alias` y `nombreTarjeta`.
- **Listado de Tarjetas:**
  - Una lista (ej. `ListView.builder`) que renderice visualmente las tarjetas filtradas.
- **Acciones Rápidas de Pago:**
  - Cada elemento de la lista debe tener un acceso rápido (ej. un botón prominente de "Pagar" o "Enviar").
  - Al presionarlo, se debe enviar el `qrCode` directamente a la función `sendPayment()` de la clase `TransfermovilService`.
- **Acciones CRUD completas:**
  - Opciones claras para **Crear** nuevas tarjetas (escanear QR y añadir alias), **Leer/Ver** detalles, **Actualizar/Editar** datos y **Eliminar** registros.

---

## 3. Consideraciones Técnicas

- **Gestión de Estado**: Toda la reactividad de la UI (como la búsqueda en tiempo real) debe ser controlada mediante `Signals`.
- **Estilos**: Respetar las guías definidas en `AGENTS.md` apoyándose estrictamente en el `Theme.of(context)`. No usar colores predefinidos (hardcoded).
- **Formatos de QR**: El agente asume que el sistema de lectura (`mobile_scanner`) extrae el texto puro y que `TransfermovilService` gestiona internamente la validación y el envío del `Intent` a Android.
