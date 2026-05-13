# Task 04 — TransactionProvider

## Goal
Create the state management layer using `ChangeNotifier` that connects the UI to the database.

## Requirements
- Create `lib/providers/transaction_provider.dart`
- Extend `ChangeNotifier`
- Maintain two internal lists:
  - `_allTransactions` — full list loaded from DB
  - `_filter` — optional `DateTimeRange?`
- Expose a filtered `transactions` getter:
  - Returns `_allTransactions` if no filter is set
  - Returns filtered list based on `_filter` date range if set
- Implement computed getters (no extra DB calls):
  - `double get totalIncome` — sum of all income transactions
  - `double get totalExpense` — sum of all expense transactions
  - `double get balance` — `totalIncome - totalExpense`
- Implement async methods:
  - `Future<void> load()` — fetches from `DBHelper`, calls `notifyListeners()`
  - `Future<void> add(Transaction t)` — inserts, then calls `load()`
  - `Future<void> update(Transaction t)` — updates, then calls `load()`
  - `Future<void> delete(int id)` — deletes, then calls `load()`
  - `void setFilter(DateTimeRange? range)` — sets `_filter`, calls `notifyListeners()`
- Register provider in `main.dart` with `ChangeNotifierProvider`

## Output
- `lib/providers/transaction_provider.dart`
- Updated `main.dart` with `ChangeNotifierProvider` wrapping `MaterialApp`

## Dependencies
- Task 03 (`DBHelper` must exist)

## Done Criteria
- [ ] `provider.load()` populates `transactions` list from DB
- [ ] `totalIncome`, `totalExpense`, `balance` return correct computed values
- [ ] `add()`, `update()`, `delete()` each trigger a reload and UI update
- [ ] `setFilter()` correctly narrows the `transactions` list
- [ ] No direct DB calls exist outside of `DBHelper`
