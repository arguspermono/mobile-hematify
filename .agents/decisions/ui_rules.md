# Decision: UI Rules

## UI Rules / Constraints

## Decision
Build UI using standard Flutter Material widgets. No external UI libraries. Use `ThemeData` for consistent styling across all screens.

## Reason
Keeps dependencies minimal and beginner-friendly. Material widgets cover all required UI patterns for this CRUD app.

## Rules / Constraints
- Define one `ThemeData` in `main.dart` — all screens inherit from it
- Never hardcode colors inline — use theme colors or named constants
- Income amounts: always display in `Colors.green.shade700`
- Expense amounts: always display in `Colors.red.shade700`
- All amounts formatted as: `NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0)`
- All dates formatted as: `DateFormat('dd MMM yyyy')`
- All `Card` widgets must use `elevation` and `borderRadius`
- All screens must have consistent horizontal padding of `16.0`
- Long text must use `TextOverflow.ellipsis` with `maxLines: 1`
- Show `CircularProgressIndicator` while async data is loading
- Show empty state widget (icon + message) when transaction list is empty
- Do not use `MediaQuery` unless strictly necessary — keep layouts simple
