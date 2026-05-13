# Decision: Coding Style

## Decision
Follow standard Dart/Flutter conventions. Keep code simple, explicit, and readable for beginners.

## Reason
Consistent style ensures AI-generated code integrates without conflict. Explicit code is easier to debug for beginners than clever abstractions.

## Rules / Constraints

### Naming
- Files: `snake_case` (e.g., `db_helper.dart`, `home_screen.dart`)
- Classes: `PascalCase` (e.g., `TransactionProvider`, `DBHelper`)
- Variables & methods: `camelCase` (e.g., `totalIncome`, `loadTransactions`)
- Private members: prefix with `_` (e.g., `_transactions`, `_filter`)

### Dart Style
- Always use `final` for variables that don't change after assignment
- Always declare return types on functions (e.g., `Future<void>`, `double`)
- Use null safety — avoid `!` unless you are certain value is non-null
- Use `??` for fallback values instead of null checks with `if`
- Prefer `async`/`await` over `.then()` chains

### Flutter Style
- One widget per file — no exceptions
- Keep `build()` methods clean — extract complex UI into private methods or widgets
- Do not put business logic inside `build()` or widget callbacks directly
- No `print()` in final code — remove all before submission

### General
- No unused imports
- No commented-out code in final submission
- Keep files under ~150 lines — split if larger
