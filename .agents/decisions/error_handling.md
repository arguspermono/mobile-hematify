# Decision: Error Handling

## Decision
Use minimal, user-facing error handling. Show `SnackBar` for user actions. Use `print()` during development only. No custom exception classes.

## Reason
This is a local-only app with no network calls. The main failure points are form validation (handled inline) and DB operations (very unlikely to fail in SQLite). Over-engineering error handling adds complexity without user benefit.

## Rules / Constraints

### Database Errors
- Wrap `DBHelper` method calls in `try/catch` only if the method can realistically fail
- If a DB error occurs, show a `SnackBar` with a simple message: `"Something went wrong. Please try again."`
- Do NOT crash the app — always catch exceptions at the provider level

### UI / User Errors
- Form validation errors: use inline `validator` on `TextFormField` — not `SnackBar`
- Successful actions (add, edit, delete): show a brief `SnackBar` confirmation
- Do NOT use `AlertDialog` for errors — only use it for delete confirmation

### Development Only
- Use `print()` freely during development to trace data flow
- Remove ALL `print()` statements before final submission

### What NOT to do
- Do not throw custom exceptions
- Do not create an `AppException` class or error wrapper
- Do not show error dialogs for SQLite operations
- Do not use `FlutterError.onError` or global error handlers
