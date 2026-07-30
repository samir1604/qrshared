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
