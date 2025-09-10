# Copilot Instructions for Admin-Janta-Sewa

## Project Overview
This is a multi-feature Flutter application for managing various public service requests, including construction, suggestion letters, complaint letters, invitations, hospital admissions, and more. The codebase is organized by feature, with each feature having its own model, controller, and view pages. Data is loaded from JSON files in `assets/data/` and displayed using custom widgets.

## Architecture & Data Flow
- **Feature Structure:** Each feature (e.g., construction, suggestionLetter, complaintLetter) has:
  - Model: Defines data structure and parsing logic (`lib/models/<feature>/`)
  - Controller: Handles data loading, filtering, and status color logic (`lib/controllers/<feature>/`)
  - Views: UI pages for listing, details, and forwarding (`lib/view/<feature>/`)
- **Data Loading:** Data is loaded from JSON files in `assets/data/` using `rootBundle.loadString` and parsed into model objects.
- **State Management:** Uses GetX (`get` package) for controller injection, state updates, and navigation.
- **Custom Widgets:** UI uses reusable widgets in `lib/widgets/` (e.g., `CustomTopAppBar`, `DetailsCard`, `FullDetailsCard`).

## Developer Workflows
- **Build:** Run `flutter pub get` then `flutter run` to build and launch the app.
- **Test:** Widget tests are in `test/`. Run with `flutter test`.
- **Assets:** Add new data files to `assets/data/` and update `pubspec.yaml` under `flutter/assets`.
- **Hot Reload:** Use `r` in the terminal or VS Code hot reload for UI changes.

## Project-Specific Patterns
- **Type-Specific Data:** Many features have multiple types (e.g., construction: newWork, pending, beneficiary; suggestionLetter: benefit, scheme, govDepartment; complaintLetter: governmentEmployee, politician, nationalStateWork, mpOffice). Models use nullable fields for each type, and views display data conditionally based on which type is present.
- **Status Color:** Controllers provide a `statusColor` method to map status strings to colors for UI consistency.
- **Navigation:** Use `Get.to()` for page navigation and pass model objects via `Get.arguments`.
- **Filtering/Sorting:** Controllers maintain RxList for all items and filtered items, with RxString for filter/sort state.

## Integration Points
- **External Packages:**
  - `get`: State management and navigation
  - `fl_chart`: Charting (used in some list pages)
  - `flutter/services.dart`: Asset loading
- **Custom App Bar & Buttons:** All pages use `CustomTopAppBar` and custom button widgets for consistent UI.

## Examples
- To add a new feature, create a model, controller, and view pages in their respective folders. Reference construction or suggestionLetter for structure.
- To display type-specific details, use conditional rendering in the details page (see `construction_details_page.dart` and `suggestion_letter_details_page.dart`).
- To add a new status, update the `statusColor` method in the relevant controller.

## Key Files & Directories
- `lib/models/` - Data models for each feature
- `lib/controllers/` - GetX controllers for each feature
- `lib/view/` - UI pages for each feature
- `assets/data/` - JSON data files
- `lib/widgets/` - Reusable UI components
- `pubspec.yaml` - Asset and dependency configuration

---
If any section is unclear or missing important project-specific details, please provide feedback or specify which workflows or patterns need more documentation.
