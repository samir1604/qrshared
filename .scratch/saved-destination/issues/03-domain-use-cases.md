# 03 - Domain Use Cases

Type: task
Status: resolved
Blocked by: 02

## Question
Implement Domain Use Cases (`GetSavedDestinations`, `SaveDestination`, `DeleteDestination`) using `fpdart`'s `Either` type to properly wrap Repository errors and return domain-safe failures.

## Answer
Created `Failure` abstract class in `core/domain/entities`.
Implemented the 3 use cases wrapping `try/catch` with `Right` and `Left(DatabaseFailure)`.
Exported them in the barrel file. consumed by the ViewModels. Ensure functional error handling (Either).
