# Task 08 — AddEditScreen (Form)

## Goal
Build the form screen for adding a new transaction or editing an existing one.

## Requirements
- Create `lib/screens/add_edit_screen.dart`
- Accept an optional `Transaction? existing` parameter
  - If `null` → Add mode
  - If provided → Edit mode (pre-fill all fields)
- Form fields (use `Form` + `GlobalKey<FormState>`):

  | Field    | Widget                   | Validation              |
  |----------|--------------------------|-------------------------|
  | Title    | `TextFormField`          | Required, not empty     |
  | Amount   | `TextFormField` (number) | Required, must be > 0   |
  | Type     | `SegmentedButton` or `DropdownButton` | Required  |
  | Category | `DropdownButtonFormField`| Required, list by type  |
  | Date     | `TextFormField` + `showDatePicker` | Required, defaults today |
  | Note     | `TextFormField`          | Optional                |

- Hardcoded category lists:
  - Income: `['Salary', 'Freelance', 'Gift', 'Other']`
  - Expense: `['Food', 'Transport', 'Shopping', 'Health', 'Bills', 'Other']`
- Category dropdown must update when type changes
- On Save button:
  - Run `form.validate()`
  - If valid: call `provider.add(t)` or `provider.update(t)`, then `Navigator.pop()`
  - If invalid: show inline error messages

## Output
- `lib/screens/add_edit_screen.dart`

## Dependencies
- Task 04 (`TransactionProvider`)
- Task 07 (`HomeScreen` must navigate here via FAB)

## Done Criteria
- [ ] FAB on HomeScreen navigates to this screen
- [ ] Submitting empty form shows validation errors
- [ ] Valid submission adds a new transaction visible in HomeScreen
- [ ] Passing an existing transaction pre-fills all fields
- [ ] Saving an edited transaction updates it in the list
