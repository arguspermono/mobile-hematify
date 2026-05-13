# Task 09 — Delete Transaction

## Goal
Implement the delete feature on `TransactionCard` with swipe-to-delete or a delete button.

## Requirements
- Choose one approach:
  - **Option A (Swipe):** Wrap `TransactionCard` in `Dismissible` in `HomeScreen`
    ```dart
    Dismissible(
      key: Key(transaction.id.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => context.read<TransactionProvider>().delete(transaction.id!),
      background: Container(color: Colors.red, child: Icon(Icons.delete, color: Colors.white)),
      child: TransactionCard(...),
    )
    ```
  - **Option B (Button):** Add delete icon to `TransactionCard`, show `showDialog` for confirmation
- After delete, show a `SnackBar`: `"Transaction deleted"`
- Balance and list must update immediately after delete

## Output
- Updated `lib/screens/home_screen.dart` (Option A)
- OR updated `lib/widgets/transaction_card.dart` (Option B)

## Dependencies
- Task 07 (`HomeScreen`)
- Task 06 (`TransactionCard`)
- Task 04 (`TransactionProvider.delete()`)

## Done Criteria
- [ ] Deleting a transaction removes it from the list
- [ ] `SummaryCard` balance updates immediately after delete
- [ ] `SnackBar` appears confirming the deletion
- [ ] No crash if list becomes empty after delete
