### Vipul Assignment App - Documentation

---

## Overview

The Vipul Assignment App is a Flutter application designed to demonstrate a clean and scalable architecture using the BLoC (Business Logic Component) pattern. The app's primary functionality revolves around fetching and displaying dynamic data from an API, allowing users to select a country and subsequently display states associated with that country.

## Architecture

The app is structured around a multi-layered architecture model, which separates concerns into Presentation, Business Logic, and Data layers. This separation enhances maintainability, scalability, and testability.

### 1. **Presentation Layer**
- **Screens and Widgets**: Contains all user interface components. For instance, `HomeScreen` displays the interactive UI where users can select countries and states.
- **Custom Widgets**: The app includes custom widgets like `CustomSpinner` which encapsulates the dropdown functionality.
- **State Management**: The app utilizes Flutter Bloc for managing state. This includes reacting to user inputs (selecting a country) and displaying lists of countries and states.

### 2. **Business Logic Layer (BLoC)**
- **CountriesBloc**: Manages the business logic associated with fetching countries and states. It reacts to user events, fetches data from the repositories, and emits states that the Presentation Layer listens to.
- **Events**: Defined actions like `LoadCountries` and `CountrySelected` trigger bloc operations.
- **States**: Represents the state of the UI at any given point in time, including loading, success, and error states.

### 3. **Data Layer**
- **Repositories**: The `CountriesRepository` and `StatesRepository` abstract the data fetching mechanisms. They communicate with external APIs and provide data to the Business Logic layer.
- **Models**: Data models like `CountryModel` define the structure of the data used within the app.

### 4. **Service Locator**
- **Dependency Injection**: The app uses `get_it` for dependency injection, which is configured in `service_locators.dart`. This setup provides a scalable way to manage dependencies throughout the app.

### 5. **Utilities and Helpers**
- **Theme Helper**: Manages theme data for the app, allowing for easy switches between dark and light modes.
- **Route Service**: Manages navigation within the app.

## Key Components

### `VipulAssignmentApp`:
This is the root widget of the application. It sets up the orientation, theme, and routes for the app, and wraps the home screen with necessary providers and blocs.

### `CountriesBloc`:
Handles all logic related to country and state data. It includes:
- Fetching countries and states upon user actions.
- Emitting different states based on the success or failure of these operations.

### `CustomSpinner`:
A reusable dropdown widget used to display and select from a list of items. It is heavily used in the `HomeScreen` to allow users to choose countries and states.

## Flow of the Application

1. **Initialization**: When the app launches, the `main()` function initializes the service locator and the root widget.
2. **User Interaction**: On the `HomeScreen`, users interact with `CustomSpinner` widgets to select a country.
3. **Data Fetching**: Selecting a country triggers a `CountrySelected` event in the `CountriesBloc`, which fetches the corresponding states and updates the UI accordingly.
4. **Error Handling**: Errors in data fetching are handled gracefully, showing error messages to the user through a snackbar.

## Conclusion

The Vipul Assignment App exemplifies a clean architecture using Flutter and Bloc, focusing on separation of concerns and reusability of components. This architecture facilitates easy maintenance and scaling of the application, accommodating new features or changes in business logic with minimal impact on other parts of the application.