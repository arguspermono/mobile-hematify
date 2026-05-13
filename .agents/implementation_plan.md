# Daily Expense Tracker — Flutter Implementation Plan

> **Stack:** Flutter · Sqflite · Provider (or setState) · No backend

---

## 1. App Architecture

```
lib/
├── main.dart
├── models/
│   └── transaction.dart        # Data model
├── database/
│   └── db_helper.dart          # Sqflite CRUD layer
├── providers/
│   └── transaction_provider.dart  # State management
├── screens/
│   ├── home_screen.dart        # Dashboard + list
│   ├── add_edit_screen.dart    # Form: add/edit
│   └── filter_screen.dart      # Date filter UI
└── widgets/
    ├── transaction_card.dart
    ├── summary_card.dart       # Saldo, income, expense
    └── category_chip.dart
```

**Rule:** UI → Provider → DBHelper → Sqflite. No direct DB calls from widgets.

---

## 2. Data Model

```dart
// models/transaction.dart
class Transaction {
  final int? id;
  final String title;
  final double amount;
  final String type;      // 'income' | 'expense'
  final String category;  // e.g. 'Food', 'Transport', 'Salary'
  final DateTime date;
  final String? note;

  // toMap() / fromMap() for SQLite
}
```

**Categories (hardcoded list):**
- Income: `Salary`, `Freelance`, `Gift`, `Other`
- Expense: `Food`, `Transport`, `Shopping`, `Health`, `Bills`, `Other`

---

## 3. Database Schema (Sqflite)

```sql
CREATE TABLE transactions (
  id       INTEGER PRIMARY KEY AUTOINCREMENT,
  title    TEXT    NOT NULL,
  amount   REAL    NOT NULL,
  type     TEXT    NOT NULL,
  category TEXT    NOT NULL,
  date     TEXT    NOT NULL,   -- ISO 8601 string
  note     TEXT
);
```

**DBHelper responsibilities:**
| Method | SQL |
|---|---|
| `insertTransaction` | `INSERT INTO transactions` |
| `getAllTransactions` | `SELECT * ORDER BY date DESC` |
| `getByDateRange` | `SELECT * WHERE date BETWEEN ? AND ?` |
| `updateTransaction` | `UPDATE transactions WHERE id = ?` |
| `deleteTransaction` | `DELETE FROM transactions WHERE id = ?` |

---

## 4. State Management

Use **Provider** (recommended) or plain **setState** for simpler approach.

```dart
// providers/transaction_provider.dart
class TransactionProvider extends ChangeNotifier {
  List<Transaction> _transactions = [];
  DateTimeRange? _filter;

  // Computed values (no extra DB query needed)
  double get totalIncome   => _transactions.where((t) => t.type == 'income').fold(0, (s, t) => s + t.amount);
  double get totalExpense  => _transactions.where((t) => t.type == 'expense').fold(0, (s, t) => s + t.amount);
  double get balance       => totalIncome - totalExpense;

  Future<void> loadTransactions() async { /* fetch from DB, notifyListeners */ }
  Future<void> addTransaction(Transaction t) async { /* insert + reload */ }
  Future<void> updateTransaction(Transaction t) async { /* update + reload */ }
  Future<void> deleteTransaction(int id) async { /* delete + reload */ }
  void setFilter(DateTimeRange? range) { _filter = range; loadTransactions(); }
}
```

> **Tip for beginners:** Start with `setState` in `home_screen.dart`, refactor to Provider once features work.

---

## 5. Key Features — Implementation Map

| Feature | Screen | Method |
|---|---|---|
| Add transaction | `add_edit_screen.dart` | Form → `provider.addTransaction()` |
| Edit transaction | `add_edit_screen.dart` | Pre-fill form → `provider.updateTransaction()` |
| Delete transaction | `transaction_card.dart` | Swipe/button → `provider.deleteTransaction()` |
| Category selection | `add_edit_screen.dart` | `DropdownButton` with hardcoded list |
| Date filter | `filter_screen.dart` | `showDateRangePicker()` → `provider.setFilter()` |
| Auto balance | `home_screen.dart` | Computed from provider: `balance`, `totalIncome`, `totalExpense` |
| Local DB | `db_helper.dart` | Sqflite singleton pattern |

---

## 6. Skills You Need to Learn

### Flutter Basics
- [ ] Stateful vs Stateless Widget
- [ ] `Column`, `Row`, `ListView.builder`
- [ ] `Navigator.push` / `Navigator.pop`
- [ ] `Form` + `TextFormField` + validation
- [ ] `DropdownButton`, `DatePicker`

### State Management
- [ ] `setState()` — for local UI state
- [ ] `ChangeNotifier` + `Provider` — for app-wide state
- [ ] `Consumer<T>` / `context.watch<T>()`

### Sqflite
- [ ] Opening a database (`openDatabase`)
- [ ] CRUD with `db.insert`, `db.query`, `db.update`, `db.delete`
- [ ] Singleton pattern for `DBHelper`
- [ ] Converting `Map<String, dynamic>` ↔ Dart objects

### Dart Essentials
- [ ] `async` / `await` / `Future`
- [ ] `List` methods: `where`, `fold`, `map`
- [ ] Null safety (`?`, `!`, `??`)

---

## 7. Two-Week Development Workflow

### Week 1 — Foundation

| Day | Goal | Output |
|---|---|---|
| 1 | Setup project, add dependencies | `pubspec.yaml` with `sqflite`, `provider`, `path` |
| 2 | Build `Transaction` model + `DBHelper` | CRUD works, tested via `print()` |
| 3 | Build `TransactionProvider` | Load/add/delete logic wired to DB |
| 4 | Build `HomeScreen` skeleton | List + summary card (dummy data ok) |
| 5 | Build `AddEditScreen` | Form with validation, category dropdown, date picker |
| 6–7 | Wire Add & Delete to real data | End-to-end: add → appears in list → delete |

### Week 2 — Features + Polish

| Day | Goal | Output |
|---|---|---|
| 8 | Implement Edit (pre-fill form) | Tap transaction → edit → save |
| 9 | Implement Date Filter | `DateRangePicker` → filtered list |
| 10 | Auto balance (income/expense summary) | Summary card shows live totals |
| 11 | UI polish (colors, icons, Snackbar) | Feels like a real app |
| 12 | Edge cases: empty state, invalid input | No crashes on bad input |
| 13 | Testing: manual run-through all features | CRUD + filter all working |
| 14 | Buffer / fix bugs | Final submission ready |

---

## 8. Dependencies (`pubspec.yaml`)

```yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite: ^2.3.0
  path: ^1.9.0
  provider: ^6.1.2
  intl: ^0.19.0    # date formatting
```

---

## 9. Beginner Pitfalls to Avoid

> [!WARNING]
> **Common mistakes:**
> - Calling `initDb()` multiple times — use a singleton `DBHelper`
> - Storing `DateTime` as-is in SQLite — always use `.toIso8601String()` and parse back
> - Forgetting `notifyListeners()` after state changes
> - Not calling `loadTransactions()` after add/update/delete

> [!TIP]
> **Best practices:**
> - Keep `DBHelper` as a private singleton: `static final DBHelper _instance = DBHelper._internal();`
> - Use `FutureBuilder` only for one-time loads; use Provider for reactive UI
> - Test each DB method in isolation before wiring to UI

---

## 10. Minimal Viable App Checklist

- [ ] Add income/expense with title, amount, category, date
- [ ] View list sorted by date (newest first)
- [ ] Edit any transaction
- [ ] Delete any transaction
- [ ] Filter list by date range
- [ ] See total balance, total income, total expense auto-updated
- [ ] Data persists after app restart (SQLite)
