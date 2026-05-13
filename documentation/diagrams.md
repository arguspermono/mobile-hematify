# Hematify — System Diagrams

This document contains the architectural and behavioral diagrams for the **Hematify** Daily Expense Tracker. These diagrams help visualize how users interact with the app and how data flows through the system.

## 1. Use Case Diagram
The Use Case diagram illustrates the primary interactions between the User and the Hematify system.

```mermaid
useCaseDiagram
    actor User

    package "Hematify App" {
        usecase "Add Transaction" as UC1
        usecase "View Transactions" as UC2
        usecase "Edit Transaction" as UC3
        usecase "Delete Transaction" as UC4
        usecase "Filter by Date" as UC5
        usecase "View Summary" as UC6
        usecase "Select Category" as UC7
        usecase "Select Type (In/Out)" as UC8
    }

    User --> UC1
    User --> UC2
    User --> UC3
    User --> UC4
    User --> UC5
    User --> UC6

    UC1 ..> UC7 : <<include>>
    UC1 ..> UC8 : <<include>>
    UC3 ..> UC7 : <<include>>
    UC3 ..> UC8 : <<include>>

    note right of UC6
      Shows Total Balance,
      Total Income,
      and Total Expense
    end note
```

---

## 2. Activity Diagram
The Activity diagram shows the operational workflow of the application, from launching the app to performing CRUD operations.

```mermaid
activityDiagram
    start
    :Launch Hematify;
    :Load Transactions from SQLite;
    :Display Home Screen;
    :Show Summary (Balance, In, Out);
    
    repeat
        if (User Action?) then (Add)
            :Open Add Form;
            :Input Title, Amount, Date;
            :Select Type & Category;
            if (Valid Input?) then (Yes)
                :Save to Database;
                :Notify Provider;
                :Update UI;
            else (No)
                :Show Validation Error;
                detach
            endif
        else if (Edit)
            :Select Transaction;
            :Open Edit Form (Pre-filled);
            :Modify Details;
            if (Valid Input?) then (Yes)
                :Update Database;
                :Notify Provider;
                :Update UI;
            else (No)
                :Show Validation Error;
                detach
            endif
        else if (Delete)
            :Swipe or Tap Delete;
            :Show Confirmation;
            if (Confirmed?) then (Yes)
                :Delete from Database;
                :Notify Provider;
                :Update UI;
            else (No)
                :Cancel Action;
            endif
        else if (Filter)
            :Select Date Range;
            :Filter Provider List;
            :Update UI;
        endif
    repeat while (Keep Using App?)
    
    stop
```

---

## 3. Architecture Overview (Reference)
As defined in the [Implementation Plan](../hematify_implementation_plan.md), the app follows this flow:
**UI (Widgets) → Provider (State) → DBHelper (Data) → SQLite (Storage)**
