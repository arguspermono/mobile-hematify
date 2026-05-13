# Decision: Architecture

## Decision
Use a simple 4-layer flat architecture: **UI → Provider → DBHelper → SQLite**. No repositories, no use cases, no domain layer.

## Reason
This is a small CRUD app. Over-layering adds complexity without benefit for a beginner project. Flat structure is easier to navigate, understand, and generate code for.

## Rules / Constraints
- UI (widgets/screens) must NEVER call `DBHelper` directly
- All DB operations must go through `TransactionProvider`
- All state reads in UI must go through `context.watch<TransactionProvider>()`
- All state mutations in UI must go through `context.read<TransactionProvider>()`
- `DBHelper` is a Singleton — one instance, never instantiated twice
- No abstract classes, interfaces, or base classes unless explicitly needed
