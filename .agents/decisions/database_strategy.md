# Decision: Database Strategy

## Decision
Use **Sqflite** with a single `DBHelper` Singleton class. One table: `transactions`. No migrations, no versioning beyond initial schema.

## Reason
Sqflite is the standard local database for Flutter. It requires no backend, works offline, and is appropriate for this project's scale. A single table is sufficient for the data model.

## Rules / Constraints
- `DBHelper` must be a private Singleton:
  ```dart
  static final DBHelper instance = DBHelper._internal();
  DBHelper._internal();
  ```
- Database is opened once via `openDatabase` — never call `openDatabase` more than once
- Table name: `transactions`
- All date values stored as ISO 8601 strings: `date.toIso8601String()`
- Parse dates on read: `DateTime.parse(map['date'])`
- `DBHelper` exposes exactly 4 public methods: `insert`, `queryAll`, `update`, `delete`
- No raw SQL outside `DBHelper` — all queries live inside this class
- Do not add multiple tables or join queries — scope is one table only
