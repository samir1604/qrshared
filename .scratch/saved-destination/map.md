# Map: SavedDestination CRUD

## Destination
Implement the CRUD operations, Use Cases, ViewModels (Signals), and Views for the `SavedDestination` feature.

## Notes
- State Management: Signals (ViewModel pattern).
- Architecture: Feature-first (`/presentation`, `/domain`, `/data`).
- ViewModels access UseCases. UseCases access Repositories.
- Storage: `hive_ce` and `hive_ce_flutter`.
- Errors must be handled functionally (e.g., `Either` with `fpdart`).

## Decisions so far
- [01-hive-setup.md](file:///d:/Proyectos/Flutter/qr_shared/.scratch/saved-destination/issues/01-hive-setup.md) — Hive adapters for SavedDestination and QRType created and registered in main.dart.
- [02-data-repository.md](file:///d:/Proyectos/Flutter/qr_shared/.scratch/saved-destination/issues/02-data-repository.md) — Interface and Hive implementation for the Repository created and injected in get_it.
- [03-domain-use-cases.md](file:///d:/Proyectos/Flutter/qr_shared/.scratch/saved-destination/issues/03-domain-use-cases.md) — Use cases implemented with fpdart error handling.
## Not yet specified
- How to handle potential errors in Hive reads/writes cleanly via the UseCases (Either/Result pattern vs exceptions).
- Pagination or limits for the list view (if necessary in the future).

## Out of scope
