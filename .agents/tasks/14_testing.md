# Task 14 — Manual Testing & Edge Cases

## Goal
Run through all features manually to verify the app is stable and handles all edge cases correctly.

## Requirements
Run each test case on a physical device or emulator:

### CRUD Tests
- [ ] Add 3 income transactions → check balance is correct sum
- [ ] Add 3 expense transactions → check balance decreases correctly
- [ ] Edit a transaction title and amount → verify list and balance update
- [ ] Delete a transaction → verify removed from list and balance adjusts

### Filter Tests
- [ ] Select a date range → only matching transactions shown
- [ ] Summary totals reflect only filtered transactions
- [ ] Clear filter → full list and totals restored

### Persistence Tests
- [ ] Add a transaction → close app → reopen → data still present
- [ ] Delete a transaction → close app → reopen → deletion persists

### Validation Tests
- [ ] Submit empty form → all error messages appear
- [ ] Enter `0` as amount → error appears
- [ ] Enter `-100` as amount → error appears

### Edge Case Tests
- [ ] No transactions in DB → empty state message visible
- [ ] Very long title (50+ chars) → text truncates with `...`, no overflow
- [ ] Large amount (e.g., `1,000,000,000`) → currency formats correctly
- [ ] Rotate device to landscape → no layout breakage

## Output
- No new code files — fix bugs discovered during testing

## Dependencies
- All tasks 01–13 must be complete

## Done Criteria
- [ ] All test cases above pass with no crashes
- [ ] `flutter analyze` returns zero errors or warnings
- [ ] All `print()` debug statements have been removed
