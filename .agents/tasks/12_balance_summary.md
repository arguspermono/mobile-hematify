# Task 12 — Balance Summary (Auto-Update)

## Goal
Verify that the balance summary in `SummaryCard` automatically reflects all CRUD operations in real time.

## Requirements
- No new code required — this is a verification and integration task
- Confirm that after each action, `SummaryCard` updates without manual refresh:
  - After **Add**: balance, income, or expense increases correctly
  - After **Edit**: balance adjusts to reflect changed amount or type
  - After **Delete**: balance adjusts immediately
  - After **Filter**: summary shows totals only for filtered transactions
- If summary does NOT update automatically, check:
  - `notifyListeners()` is called after every DB operation in the provider
  - `SummaryCard` uses `context.watch<TransactionProvider>()` (not `context.read`)
  - Computed getters (`totalIncome`, `totalExpense`, `balance`) operate on the `transactions` getter (filtered list), not `_allTransactions`

## Output
- No new files — fixes in existing provider or widget if needed

## Dependencies
- Task 04 (`TransactionProvider` computed getters)
- Task 05 (`SummaryCard`)
- Tasks 08, 09, 10 (CRUD + filter all wired)

## Done Criteria
- [ ] Add income → balance increases, income total increases
- [ ] Add expense → balance decreases, expense total increases
- [ ] Edit transaction amount → balance reflects new value
- [ ] Delete transaction → balance updates instantly
- [ ] Apply date filter → summary shows only filtered totals
