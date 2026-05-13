# Decision: State Management

## Decision
Use **Provider** (`ChangeNotifier` + `ChangeNotifierProvider`) as the primary state management solution. Use `setState` only for purely local UI state (e.g., toggling a form field).

## Reason
Provider is the simplest reactive state management that scales across screens without prop-drilling. It integrates cleanly with `DBHelper` and is beginner-accessible. `setState` alone cannot share state between `HomeScreen` and `AddEditScreen`.

## Rules / Constraints
- One provider class: `TransactionProvider` — do not create multiple providers
- Register `ChangeNotifierProvider` at the root of the widget tree in `main.dart`
- Use `context.watch<TransactionProvider>()` in widgets that need to rebuild on change
- Use `context.read<TransactionProvider>()` in callbacks (e.g., button `onPressed`) — never in `build()`
- Always call `notifyListeners()` after any state change
- Never call `notifyListeners()` inside `build()`
- Computed values (`balance`, `totalIncome`, `totalExpense`) must be Dart getters — not stored fields
- `setState` is acceptable inside `AddEditScreen` for local form field state (e.g., switching category list on type change)
