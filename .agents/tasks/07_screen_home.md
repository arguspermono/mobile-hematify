# Task 07 — HomeScreen

## Goal
Build the main dashboard screen showing the summary card, transaction list, and FAB button.

## Requirements
- Create `lib/screens/home_screen.dart`
- Use `StatefulWidget`, call `provider.load()` in `initState()`
- Layout (top to bottom):
  1. `SummaryCard` widget at the top
  2. Optional: "Filter by Date" button in `AppBar` actions
  3. `ListView.builder` rendering `TransactionCard` for each transaction
  4. `FloatingActionButton` (➕) to navigate to `AddEditScreen`
- Empty state: if `transactions` is empty, show centered icon + message "No transactions yet"
- Read transaction list from provider using `context.watch<TransactionProvider>().transactions`

## Output
- `lib/screens/home_screen.dart`

## Dependencies
- Task 04 (`TransactionProvider`)
- Task 05 (`SummaryCard`)
- Task 06 (`TransactionCard`)

## Done Criteria
- [ ] `SummaryCard` is visible at the top on launch
- [ ] `ListView` shows all transactions from provider
- [ ] Empty state message shows when list is empty
- [ ] FAB is tappable (navigation wired in Task 08)
- [ ] No errors when app restarts with existing DB data
