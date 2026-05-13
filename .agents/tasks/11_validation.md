# Task 11 — Form Validation

## Goal
Ensure all form fields in `AddEditScreen` are fully validated before submission.

## Requirements
- Validate all required fields in `AddEditScreen`:
  - `title` — cannot be empty or whitespace-only
  - `amount` — must be a valid number and greater than 0
  - `type` — must be selected
  - `category` — must be selected from the dropdown
  - `date` — must be a valid, non-null date
- Use `TextFormField`'s `validator` property for inline error messages
- Call `form.currentState!.validate()` in the Save button's `onPressed`
- Block submission if any field fails validation
- Prevent negative amounts: parse input and reject if `<= 0`

## Output
- Updated `lib/screens/add_edit_screen.dart` with full validation logic

## Dependencies
- Task 08 (`AddEditScreen` must exist)

## Done Criteria
- [ ] Submitting empty form shows red error text under each invalid field
- [ ] Entering `0` or negative amount shows an error
- [ ] Entering a valid form and pressing Save succeeds without errors
- [ ] Invalid form submission does NOT navigate or call provider methods
