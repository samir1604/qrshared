# QR Shared Context

This context defines the ubiquitous language and core concepts for the QR Shared application.

## Language

**PaymentCard**:
The core domain entity representing a payment destination or merchant, extracted from a scanned QR code.
_Avoid_: Tarjeta de Pago, Beneficiario.

**PaymentService**:
An abstraction for processing payments. The implementation for Android is `TransfermovilService`.
_Avoid_: Direct TransfermovilService coupling.

**QR Code**:
The raw string payload extracted from the scanner, used to initiate a payment.

**SavedDestination**:
A persistently stored payment destination (merchant or friend) that the user frequently pays.

| Field | Data Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `id` | `String` | Yes | Unique identifier (UUID or timestamp). |
| `name` | `String` | Yes | Official name (JSON title for payments, or "Transferencia a [phone]"). |
| `alias` | `String?` | No | Custom name given by the user (e.g., "Corner store"). |
| `type` | `QRType` | Yes | Enum to differentiate logic (`payment` vs `transfer`). |
| `rawQrData` | `String` | Yes | Original QR data (JSON or text) for the intent. |
| `phone` | `String?` | Depends | Mandatory for transfer, optional for online payment. |
| `accountOrProviderNumber` | `String?` | No | Visual convenience: 16-digit card or provider number. |
| `observation` | `String?` | No | Notes about the store (prices, quality, etc.). |
| `createdAt` | `DateTime` | Yes | Record creation date. |

_Avoid_: PaymentAccount, Cuenta de pago, SavedMerchant.
