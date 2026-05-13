# Task 03 — DBHelper (SQLite Layer)

## Goal
Create the database helper class with full CRUD operations using the Singleton pattern.

## Requirements
- Create `lib/database/db_helper.dart`
- Use Singleton pattern: `static final DBHelper instance = DBHelper._internal();`
- Open database with `openDatabase`, create table in `onCreate`
- SQL schema:
  ```sql
  CREATE TABLE transactions (
    id       INTEGER PRIMARY KEY AUTOINCREMENT,
    title    TEXT    NOT NULL,
    amount   REAL    NOT NULL,
    type     TEXT    NOT NULL,
    category TEXT    NOT NULL,
    date     TEXT    NOT NULL,
    note     TEXT
  );
  ```
- Implement these methods:
  - `Future<int> insert(Transaction t)` — uses `db.insert`
  - `Future<List<Transaction>> queryAll()` — uses `db.query`, orders by date DESC
  - `Future<int> update(Transaction t)` — uses `db.update` with WHERE id = ?
  - `Future<int> delete(int id)` — uses `db.delete` with WHERE id = ?

## Output
- `lib/database/db_helper.dart`

## Dependencies
- Task 02 (`Transaction` model must exist)

## Done Criteria
- [ ] Singleton instance returns same object each call
- [ ] `insert()` successfully writes to DB
- [ ] `queryAll()` returns list with correct `Transaction` objects
- [ ] `update()` changes values in DB
- [ ] `delete()` removes row by id
- [ ] All verified via `print()` in `main.dart`
