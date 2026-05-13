### 1. Flutter UI Skills
* Using `StatelessWidget` and `StatefulWidget`
* Building vertical and horizontal layouts using `Column` and `Row`
* Creating scrollable dynamic lists with `ListView.builder`
* Extracting UI into reusable custom components (`TransactionCard`, `SummaryCard`, `CategoryChip`)
* Applying visual styling using `Card`, `BorderRadius`, and colors
* Displaying empty states and loading indicators (`CircularProgressIndicator`)

### 2. Navigation & Forms
* Moving between screens with `Navigator.push` and `Navigator.pop`
* Setting up a `Form` with a `GlobalKey<FormState>`
* Collecting text and numeric input using `TextFormField`
* Creating selection menus with `DropdownButton` and `SegmentedButton`
* Implementing user input validation (e.g., required, not empty, greater than zero)
* Triggering and handling `showDatePicker` and `showDateRangePicker`
* Displaying brief UI feedback messages using `SnackBar`

### 3. State Management Skills
* Managing local UI changes using `setState()`
* Setting up a `ChangeNotifier` class (`TransactionProvider`)
* Wrapping the app in a `ChangeNotifierProvider`
* Accessing state methods and listening for updates using `context.read()` and `context.watch()`
* Triggering UI rebuilds by calling `notifyListeners()`
* Creating computed getters for real-time calculations (total income, total expense, balance)

### 4. Sqflite & Local Database Skills
* Creating a private Singleton class for database access (`DBHelper`)
* Initializing the database using `openDatabase`
* Writing raw SQL to define table schemas (`CREATE TABLE`)
* Executing local CRUD operations (`db.insert`, `db.queryAll`, `db.update`, `db.delete`)
* Converting Dart objects to Maps for database insertion (`toMap()`)
* Parsing Maps from the database back into Dart objects (`fromMap()`)

### 5. Dart Fundamentals
* Creating data model classes with properties and constructors
* Handling null safety operators (`?`, `!`, `??`)
* Managing asynchronous operations using `async`, `await`, and `Future`
* Filtering and transforming lists using `.where()`, `.fold()`, and `.map()`
* Formatting standard dates into strings using `.toIso8601String()` and `DateTime.parse()`
* Utilizing the `intl` package for currency (`NumberFormat`) and date display (`DateFormat`)

### 6. Debugging & Testing Skills
* Using `print()` to verify data flow before connecting the UI
* Testing manual end-to-end CRUD user flows on an emulator
* Checking edge cases (e.g., empty database, missing inputs, massive numbers)
* Verifying database persistence by completely closing and reopening the app
* Reading console logs to fix validation or SQLite constraint errors
