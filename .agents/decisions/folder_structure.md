# Decision: Folder Structure

## Decision
Use a feature-flat, layer-based folder structure under `lib/`. No feature folders, no nested sub-packages.

## Reason
The app has one feature (expense tracking) and four layers. Nesting by feature would be overkill. Flat layers keep file navigation simple and predictable.

## Rules / Constraints
- Exact folder structure — do not deviate:
  ```
  lib/
  ├── main.dart
  ├── models/
  │   └── transaction.dart
  ├── database/
  │   └── db_helper.dart
  ├── providers/
  │   └── transaction_provider.dart
  ├── screens/
  │   ├── home_screen.dart
  │   └── add_edit_screen.dart
  └── widgets/
      ├── summary_card.dart
      └── transaction_card.dart
  ```
- `models/` — data classes only, no logic
- `database/` — only `DBHelper`, no other files
- `providers/` — only `TransactionProvider`, no other files
- `screens/` — one file per screen, screen = full page
- `widgets/` — reusable components used across screens
- Do NOT create: `utils/`, `helpers/`, `services/`, `constants/` — keep them flat unless explicitly needed
- Do NOT create subfolders inside any of these directories
