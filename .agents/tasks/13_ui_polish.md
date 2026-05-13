# Task 13 — UI Polish

## Goal
Improve the visual appearance of the app to feel clean and intentional.

## Requirements
- Define a consistent `ThemeData` in `main.dart`:
  - Primary color, accent color, and card theme
  - Use a custom font from Google Fonts (optional: `google_fonts` package) or set `fontFamily`
- Apply to all screens:
  - Consistent padding and spacing (e.g., `16.0` horizontal margins)
  - `Card` with `elevation` and `borderRadius` on all cards
  - Income amount: green text (`Colors.green.shade700`)
  - Expense amount: red text (`Colors.red.shade700`)
- Add category icons to `TransactionCard`:
  - Use `Icons.*` matched to category name (e.g., `Icons.restaurant` for Food)
- Add `CircularProgressIndicator` while DB is loading
- Handle long title overflow with `TextOverflow.ellipsis`
- Test on both portrait and landscape orientations — layouts must not break

## Output
- Updated `main.dart` (ThemeData)
- Updated `lib/widgets/transaction_card.dart` (icons, overflow)
- Updated `lib/widgets/summary_card.dart` (consistent styling)

## Dependencies
- All previous tasks must be complete

## Done Criteria
- [ ] App has a consistent color theme across all screens
- [ ] Income/expense amounts are color-coded green/red
- [ ] Category icons appear in `TransactionCard`
- [ ] No text overflow or layout breakage in landscape mode
- [ ] Loading indicator appears briefly when DB is fetched
