# Task 10 — Date Filter

## Goal
Add a date range filter to `HomeScreen` that narrows the transaction list by selected dates.

## Requirements
- Add a filter icon button to `HomeScreen` AppBar
- On tap, call:
  ```dart
  DateTimeRange? picked = await showDateRangePicker(
    context: context,
    firstDate: DateTime(2020),
    lastDate: DateTime.now(),
  );
  if (picked != null) {
    context.read<TransactionProvider>().setFilter(picked);
  }
  ```
- When filter is active:
  - Show a "Clear Filter" button in the AppBar or below the summary card
  - Tapping it calls `provider.setFilter(null)`
- The `transactions` getter in the provider handles filtering logic (already implemented in Task 04)

## Output
- Updated `lib/screens/home_screen.dart` with filter button and clear filter action

## Dependencies
- Task 04 (`TransactionProvider.setFilter()`)
- Task 07 (`HomeScreen`)

## Done Criteria
- [ ] Tapping filter icon opens `DateRangePicker`
- [ ] After selecting a range, only matching transactions are shown
- [ ] `SummaryCard` totals update to reflect only filtered transactions
- [ ] "Clear Filter" button appears when filter is active
- [ ] Clearing filter restores the full list
