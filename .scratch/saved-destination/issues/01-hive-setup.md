# 01 - Hive Setup

Type: task
Status: resolved

## Question
Configure `hive_ce` adapters for the `SavedDestination` entity and the `QRType` enum. Initialize the Hive box at application startup.

## Answer
Added `build_runner` and `hive_ce_generator` dependencies.
Extracted `QRType` to `lib/src/core/domain/qr_type.dart` with Hive annotations.
Created `SavedDestination` in `lib/src/features/saved_destinations/domain/saved_destination.dart` with Hive annotations.
Generated `.g.dart` adapters via build_runner.
Initialized Hive and registered adapters in `main.dart`, opening the `saved_destinations` box.
