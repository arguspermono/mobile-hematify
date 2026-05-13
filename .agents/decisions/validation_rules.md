# Decision: Validation Rules

## Decision
All input validation is handled inline using `TextFormField`'s `validator` property inside `AddEditScreen`. No separate validator classes or functions.

## Reason
Inline validators are the standard Flutter pattern for form validation. They provide immediate, co-located feedback without extra abstractions.

## Rules / Constraints

### Field-Level Rules

| Field    | Rule                                               |
|----------|----------------------------------------------------|
| Title    | Cannot be empty or whitespace-only                 |
| Amount   | Cannot be empty; must parse to a `double`; must be `> 0` |
| Type     | Must be selected (`'income'` or `'expense'`)       |
| Category | Must be selected from the list for the given type  |
| Date     | Must be a valid, non-null `DateTime`; defaults to today |
| Note     | Optional — no validation required                  |

### Implementation Rules
- Always call `_formKey.currentState!.validate()` in the Save button's `onPressed`
- Block navigation (`Navigator.pop`) if `validate()` returns `false`
- Do NOT call `provider.add()` or `provider.update()` if the form is invalid
- Amount parsing: use `double.tryParse(value) ?? -1` — treat null/unparsable as invalid
- Reject amounts `<= 0` explicitly: `if (value <= 0) return 'Amount must be greater than 0'`
- Category list must match the selected type — update dropdown when type changes

### What NOT to do
- Do not create a separate `Validator` utility class
- Do not validate on every keystroke (use `autovalidateMode: AutovalidateMode.onUserInteraction` if needed)
- Do not allow form submission to proceed with invalid data under any condition
