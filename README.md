# PokeDest
## Overview

The Pokémon App provides a simple interface to view a list of Pokémon and their details. It uses the [PokeAPI](https://pokeapi.co/docs/) to fetch Pokémon data and display relevant information in an organized manner. The app allows users to toggle between a single-column view or a two-column view for the Pokémon list. Selecting a Pokémon from the list navigates to a detail view that shows its image, name, description, and abilities.

## Features

- **Pokémon Display**: Shows a list of Pokémon in a `UICollectionView` that can be configured to display items in either a single-column or two-column layout.
- **Detail Navigation**: Selecting a Pokémon in the list navigates to a detail view displaying the Pokémon’s image, name, description, and abilities.
- **Layout Configuration**: Uses `UICollectionViewFlowLayout` to adjust the layout of the `UICollectionView` with appropriate spacing between items and the ability to switch between single-column and two-column views.
- **Asynchronous Image Loading**: Utilizes the `SDWebImage` library for asynchronous image loading, ensuring images load efficiently without blocking the user interface.
- **User Interface**:
  - **Pokémon List**: Pokémon are displayed in `UICollectionView` cells with an image and name, and the ability to toggle between a single-column and two-column view.
  - **Detail View**: The detail view provides an in-depth look at the selected Pokémon, including a larger image, name, description, and a list of abilities.
  - **User Interaction**: Allows users to toggle the display between one column and two columns using a `UISwitch` located at the top of the view.

## Architecture

The project follows the VIPER architecture pattern, which stands for View, Interactor, Presenter, Entity, and Router. This architecture provides a clear separation of concerns and promotes testability and maintainability.

## Classes Relationship

- **View**: Responsible for presenting the user interface and handling user interactions.
- **Interactor**: Contains the business logic and interacts with data sources to fetch and manipulate data.
- **Presenter**: Mediates between the view and the interactor, formatting data from the interactor for display in the view.
- **Entity**: Represents the data model used by the application.
- **Router**: Handles navigation between different screens or modules within the application.

## Installation

1. Clone the repository.
2. Open the project in Xcode.
3. **From Xcode:**
   - Go to File > Swift Packages > Resolve Package Versions.
   - This will trigger Xcode to resolve and download any missing dependencies using Swift Package Manager (SPM).
   
   **From the console:**
   - Navigate to your project's root directory in Terminal.
   - Run the following command to update dependencies using Swift Package Manager (SPM):
     ```
     swift package resolve
     ```
   - This will download and resolve any missing dependencies.
   
4. Build and run the project on a simulator or device.

## Dependencies

- [SDWebImage](https://github.com/SDWebImage/SDWebImage): Library for asynchronous image loading and caching.


## Usage

1. Launch the app.
2. View the splash screen.
3. Navigate to the pokemon listing screen.
4. Select an pokemon to view its details.
5. See the details

## Running Unit Tests

1. Open the Xcode project.
2. Navigate to the project navigator.
3. Select the target containing the unit tests.
4. Go to Product > Test or use the shortcut ⌘U.
5. Xcode will compile the project and execute the unit tests.
6. View the test results in the Xcode test navigator or the console output.

