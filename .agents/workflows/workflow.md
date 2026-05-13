# Development Workflow — Daily Expense Tracker (Flutter)

> **Duration:** 2 weeks · **Target:** Student project · **Approach:** Feature-first, test as you build

---

## Phase 1 — Foundation (Day 1–3)

### Day 1 · Project Setup
**Goal:** Runnable app with all dependencies installed.

```yaml
# pubspec.yaml — add these
dependencies:
  sqflite: ^2.3.0
  path: ^1.9.0
  provider: ^6.1.2
  intl: ^0.19.0
```

Tasks:
- [ ] `flutter create expense_tracker` → clean default code from `main.dart`
- [ ] Add dependencies → `flutter pub get`
- [ ] Create folder structure: `models/`, `database/`, `providers/`, `screens/`, `widgets/`
- [ ] Set up `MaterialApp` with a placeholder `HomeScreen`

✅ **Done when:** App runs on emulator with no errors, shows blank scaffold.

---

### Day 2 · Data Model + DBHelper
**Goal:** DB is wired and CRUD works — tested via `print()`, no UI needed.

```dart
// models/transaction.dart
class Transaction {
  final int? id;
  final String title;
  final double amount;
  final String type;      // 'income' | 'expense'
  final String category;
  final DateTime date;
  final String? note;

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'amount': amount,
    'type': type,
    'category': category,
    'date': date.toIso8601String(),
    'note': note,
  };

  factory Transaction.fromMap(Map<String, dynamic> map) => Transaction(
    id: map['id'],
    title: map['title'],
    amount: map['amount'],
    type: map['type'],
    category: map['category'],
    date: DateTime.parse(map['date']),
    note: map['note'],
  );
}
```

Tasks:
- [ ] Create `Transaction` model with `toMap()` / `fromMap()`
- [ ] Create `DBHelper` singleton with `openDatabase` + `onCreate`
- [ ] Implement `insert`, `queryAll`, `update`, `delete` methods
- [ ] Test in `main.dart` using `print()` — insert a dummy record, query it back

✅ **Done when:** Console prints a transaction after insert + query with correct values.

---

### Day 3 · TransactionProvider
**Goal:** State management layer is ready.

```dart
// providers/transaction_provider.dart
class TransactionProvider extends ChangeNotifier {
  List<Transaction> _transactions = [];

  List<Transaction> get transactions => _transactions;
  double get totalIncome  => _transactions.where((t) => t.type == 'income').fold(0.0, (s, t) => s + t.amount);
  double get totalExpense => _transactions.where((t) => t.type == 'expense').fold(0.0, (s, t) => s + t.amount);
  double get balance      => totalIncome - totalExpense;

  Future<void> load() async {
    _transactions = await DBHelper.instance.queryAll();
    notifyListeners();
  }

  Future<void> add(Transaction t) async {
    await DBHelper.instance.insert(t);
    await load();
  }

  Future<void> update(Transaction t) async {
    await DBHelper.instance.update(t);
    await load();
  }

  Future<void> delete(int id) async {
    await DBHelper.instance.delete(id);
    await load();
  }
}
```

Tasks:
- [ ] Create `TransactionProvider` with computed getters
- [ ] Register with `ChangeNotifierProvider` in `main.dart`
- [ ] Call `provider.load()` in `HomeScreen.initState()`

✅ **Done when:** Provider loads data and computed values return correct numbers.

---

## Phase 2 — Core Features (Day 4–8)

### Day 4 · HomeScreen — List + Summary Card
**Goal:** Show all transactions and the balance summary.

Layout:
```
┌─────────────────────────┐
│  Balance: Rp 500.000    │  ← SummaryCard widget
│  In: Rp 1jt  Out: Rp 500k │
├─────────────────────────┤
│  [Filter by Date] button│
├─────────────────────────┤
│  • Makan siang   -15k  │  ← ListView.builder
│  • Gaji          +5jt  │     TransactionCard widget
│  • Transport     -20k  │
└─────────────────────────┘
```

Tasks:
- [ ] Build `SummaryCard` widget — reads from `context.watch<TransactionProvider>()`
- [ ] Build `TransactionCard` widget — title, amount, category, date
- [ ] `ListView.builder` in `HomeScreen` rendering `TransactionCard`
- [ ] FAB (`+`) button → placeholder navigation (no form yet)
- [ ] Handle empty state: show icon + "No transactions yet"

✅ **Done when:** Dummy/hardcoded data shows in list with correct colors (income=green, expense=red).

---

### Day 5 · AddEditScreen — Form
**Goal:** Form works with validation.

Fields:
| Field | Widget | Validation |
|---|---|---|
| Title | `TextFormField` | Required, not empty |
| Amount | `TextFormField` (number keyboard) | Required, > 0 |
| Type | `SegmentedButton` or `DropdownButton` | Required |
| Category | `DropdownButtonFormField` | Required, list changes by type |
| Date | `TextFormField` + `showDatePicker` | Required, defaults to today |
| Note | `TextFormField` | Optional |

Tasks:
- [ ] Build form layout with `Form` + `GlobalKey<FormState>`
- [ ] Implement `showDatePicker` for date field
- [ ] Dynamic category list based on selected type (income/expense)
- [ ] `Save` button calls `form.validate()` — show errors if invalid
- [ ] On valid submit: create `Transaction` object, call `provider.add(t)`, pop screen

✅ **Done when:** Filling and submitting form adds a transaction visible in HomeScreen.

---

### Day 6 · Edit Existing Transaction
**Goal:** Tap a transaction → pre-fill form → save updates it.

Tasks:
- [ ] Pass existing `Transaction` as optional arg to `AddEditScreen`
- [ ] Pre-fill all form fields from the passed object
- [ ] On save: call `provider.update(t)` instead of `provider.add(t)`
- [ ] Navigate to edit screen from `TransactionCard` (tap or edit icon)

✅ **Done when:** Edit a transaction → values persist after navigating back.

---

### Day 7 · Delete Transaction
**Goal:** Delete with confirmation dialog.

Two options (pick one):

**Option A — Swipe to delete:**
```dart
Dismissible(
  key: Key(transaction.id.toString()),
  direction: DismissDirection.endToStart,
  onDismissed: (_) => context.read<TransactionProvider>().delete(transaction.id!),
  background: Container(color: Colors.red, child: Icon(Icons.delete)),
  child: TransactionCard(transaction: transaction),
)
```

**Option B — Delete button in card** → `showDialog` → confirm → `provider.delete(id)`

Tasks:
- [ ] Implement chosen delete method
- [ ] Show `SnackBar` after delete: "Transaction deleted"
- [ ] Optionally: add undo via `SnackBar` action (stretch goal)

✅ **Done when:** Delete removes transaction from list and updates balance.

---

### Day 8 · Date Filter
**Goal:** Filter list by date range.

```dart
// In HomeScreen or FilterScreen
DateTimeRange? picked = await showDateRangePicker(
  context: context,
  firstDate: DateTime(2020),
  lastDate: DateTime.now(),
);
if (picked != null) {
  context.read<TransactionProvider>().setFilter(picked);
}
```

Add to `TransactionProvider`:
```dart
DateTimeRange? _filter;

List<Transaction> get transactions => _filter == null
  ? _allTransactions
  : _allTransactions.where((t) =>
      !t.date.isBefore(_filter!.start) &&
      !t.date.isAfter(_filter!.end)
    ).toList();

void setFilter(DateTimeRange? range) {
  _filter = range;
  notifyListeners();
}
```

Tasks:
- [ ] Add filter button to `HomeScreen` AppBar
- [ ] Call `showDateRangePicker` on tap
- [ ] Pass range to `provider.setFilter()`
- [ ] Add "Clear Filter" button when filter is active

✅ **Done when:** Selecting a date range shows only matching transactions.

---

## Phase 3 — Polish + Testing (Day 9–14)

### Day 9 · Auto Balance + Currency Formatting

Tasks:
- [ ] Format all amounts with `intl`: `NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(amount)`
- [ ] Format dates: `DateFormat('dd MMM yyyy').format(date)`
- [ ] `SummaryCard` shows balance, total income, total expense — all auto-updating
- [ ] Test: add income → balance increases. Add expense → balance decreases.

✅ **Done when:** Balance reflects all CRUD operations in real time.

---

### Day 10 · UI Polish

Tasks:
- [ ] Consistent color theme: define primary/accent colors in `ThemeData`
- [ ] Income amount: green text. Expense amount: red text.
- [ ] Category icons (use `Icons.*` based on category name)
- [ ] Card shadows, rounded corners (`Card` + `BorderRadius`)
- [ ] Loading indicator while DB fetches (`CircularProgressIndicator`)
- [ ] Responsive padding/spacing on all screens

✅ **Done when:** App looks clean and intentional, not default Flutter grey.

---

### Day 11 · Edge Cases + Validation

Tasks:
- [ ] Block negative amounts in form
- [ ] Block future dates (or decide to allow them)
- [ ] What happens with empty DB? — verify empty state shows
- [ ] Large amounts (>1 billion) — test currency formatting
- [ ] Very long title text — test card overflow (`TextOverflow.ellipsis`)
- [ ] Rotate device — check layouts don't break

✅ **Done when:** No crash or visual break on any edge case.

---

### Day 12–13 · Manual Testing Checklist

Run through every feature end-to-end:

- [ ] Add 3 income transactions → balance is correct
- [ ] Add 3 expense transactions → balance decreases correctly
- [ ] Edit a transaction → changes reflect in list and balance
- [ ] Delete a transaction → removed from list, balance updates
- [ ] Filter by date range → only matching transactions shown
- [ ] Clear filter → full list returns
- [ ] Kill app and restart → all data still present (SQLite persistence)
- [ ] Add transaction with missing fields → validation errors show
- [ ] No transactions → empty state visible

---

### Day 14 · Buffer + Final Submission

Tasks:
- [ ] Fix any bugs found in testing
- [ ] Remove all `print()` debug statements
- [ ] Check `pubspec.yaml` is clean
- [ ] Run `flutter analyze` — fix all warnings
- [ ] Final run on physical device or emulator
- [ ] Take screenshots for documentation

---

## Build Order Summary

```
Day 1  → Setup
Day 2  → Model + DB
Day 3  → Provider
Day 4  → HomeScreen UI
Day 5  → Add Form
Day 6  → Edit
Day 7  → Delete
Day 8  → Date Filter
Day 9  → Balance + Formatting
Day 10 → Polish
Day 11 → Edge Cases
Day 12-13 → Manual Testing
Day 14 → Fix + Submit
```

> [!TIP]
> **If you fall behind:** Skip Day 10 (UI polish) and Day 11 (edge cases) first.
> Core features (CRUD + filter + balance) are the minimum viable submission.
