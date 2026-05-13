# Task 05 — SummaryCard Widget

## Goal
Build the reusable widget that displays the financial summary (balance, income, expense) at the top of the home screen.

## Requirements
- Create `lib/widgets/summary_card.dart`
- Widget reads data from `TransactionProvider` using `context.watch<TransactionProvider>()`
- Display three values:
  - **Balance** — prominent, centered, formatted as currency
  - **Total Income** — green text with label
  - **Total Expense** — red text with label
- Format all amounts using `intl`:
  ```dart
  NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(amount)
  ```
- Style with `Card`, rounded corners, and background color

## Output
- `lib/widgets/summary_card.dart`

## Dependencies
- Task 04 (`TransactionProvider` must exist with computed getters)

## Done Criteria
- [ ] Widget renders without errors
- [ ] Balance, income, and expense values display correctly
- [ ] Values update automatically when provider state changes
- [ ] Currency formatting shows `Rp` with no decimals
