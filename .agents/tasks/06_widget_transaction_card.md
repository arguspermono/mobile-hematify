# Task 06 — TransactionCard Widget

## Goal
Build the reusable widget that displays a single transaction as a list tile.

## Requirements
- Create `lib/widgets/transaction_card.dart`
- Accept a `Transaction` object as a constructor parameter
- Display:
  - `title` — bold text
  - `amount` — formatted as currency, green if `type == 'income'`, red if `type == 'expense'`
  - `category` — shown as a chip or subtitle label
  - `date` — formatted using `DateFormat('dd MMM yyyy').format(date)` from `intl`
- Wrap in a `Card` with padding and rounded corners
- Must be tappable (leave `onTap` as an empty callback for now — wired in Task 08)

## Output
- `lib/widgets/transaction_card.dart`

## Dependencies
- Task 02 (`Transaction` model)
- Task 05 (consistent styling with `SummaryCard`)

## Done Criteria
- [ ] Widget renders a single transaction with all four fields visible
- [ ] Income amount appears in green, expense in red
- [ ] Date is formatted as `dd MMM yyyy` (e.g., `13 May 2026`)
- [ ] Card has visible shadow and rounded corners
