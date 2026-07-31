# Requirements Document - QR Shared App

## 1. Data Model (PaymentCard)

The central data model of the application is **PaymentCard**. This model will be used to locally store cards using the `hive_ce` database, optimizing searches and fast in-memory access.

### 1.1 Model Fields

| Field | Type | Required | Description |
| :--- | :--- | :---: | :--- |
| `qrCode` | `String` | **Yes** | The text or JSON containing the scanned QR code (needed for the Intent). |
| `cardName` | `String` | **Yes** | Card name (usually provided by the merchant). |
| `cardNumber` | `String` | **Yes** | Identifier number of the card or account. |
| `alias` | `String?` | No | Custom name set by the user to easily remember the card. |
| `phone` | `String?` | No | Phone number associated with the merchant (required by some). |
| `address` | `String?` | No | Merchant's address (used as a reminder). |
| `notes`| `String?` | No | Additional notes about the merchant or the card. |

---

## 2. User Interface (UI) and Functionality

The main card management screen (Features: `cards`) must meet the following specifications:

### 2.1 Main Components
- **Search Bar (Buscador):** 
  - A text field at the top.
  - When typing, it must filter the list of stored cards in real-time (using `Signals` state) by matching the `alias` and `cardName` fields.
- **Card List:**
  - A list (e.g., `ListView.builder`) that visually renders the filtered cards.
- **Quick Payment Actions:**
  - Each item in the list must have a quick access action (e.g., a prominent "Pay" or "Send" button).
  - When pressed, it must send the `qrCode` to the `PaymentService` handler (with its `TransfermovilService` implementation).

---

## 3. Technical Considerations

- **Platform**: The application is strictly restricted to **Android**, given that it depends on native intents for the Transfermóvil app.
- **State Management**: All UI reactivity (such as real-time search) must be controlled via `Signals` and dependencies injected with `get_it`.
- **Styling**: Respect the guidelines defined in `AGENTS.md` relying strictly on `Theme.of(context)`. Do not use hardcoded colors.
- **QR Formats**: The agent assumes that the scanning system (`mobile_scanner`) extracts the raw text and that `TransfermovilService` internally manages the validation and sending of the `Intent` to Android.
