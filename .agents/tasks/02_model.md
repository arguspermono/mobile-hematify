# Task 02 — Transaction Model

## Goal
Create the `Transaction` data model class with all fields and serialization methods.

## Requirements
- Create `lib/models/transaction.dart`
- Class must include these fields:
  - `int? id`
  - `String title`
  - `double amount`
  - `String type` — values: `'income'` or `'expense'`
  - `String category`
  - `DateTime date`
  - `String? note`
- Implement `toMap()` — converts object to `Map<String, dynamic>` for SQLite
- Implement `factory Transaction.fromMap(Map<String, dynamic>)` — parses DB row back to object
- Store `date` as ISO 8601 string: `date.toIso8601String()`

## Output
- `lib/models/transaction.dart`

## Dependencies
- Task 01 (project structure must exist)

## Done Criteria
- [ ] Can create a `Transaction` object manually in `main.dart`
- [ ] `toMap()` returns correct key-value pairs
- [ ] `fromMap()` correctly parses a Map back to a `Transaction`
- [ ] `print()` in `main.dart` shows expected field values
