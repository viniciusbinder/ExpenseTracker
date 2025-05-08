## Exploring Layered Architecture: ExpenseTracker

A project to learn the ropes of using the **repository design pattern** in a **thin domain-based architecture** for iOS applications inspired by Clean Architecture. It improves separation of concerns and testability, and since all layers are separate, tests for all parts are able to be written separately and concisely.

### Implementation

- Clean MVVM + **Repository** pattern with protocol-based data access
- **Domain** layer for holding models and repository protocols
- `Swift 6` Complete Concurrency Checking
- Single source of truth for shared data (`actor`-based storage)
- Support for multiple data sources (`InMemory`, `SwiftData`)
- _ViewModels_ expose `async` methods instead of handling Tasks
- `Swift Testing` suite with full coverage of _Services_, _ViewModels_ and _Repositories_
- Simple dependency injection using a `ViewModelFactory`

### Architecture

```
+---------------+-----------------+
|      UI       | - Views         |
+---------------+-----------------+
                v
+---------------+-----------------+
|               | - Models        |
|  Application  | - Services      |
|               | - ViewModels    |
+---------------+-----------------+
                v
+---------------+-----------------+
|               | - Models        |
|    Domain     | - Repositories  |
|               |                 |
+---------------+-----------------+
                ^
+---------------+----------------------+
|               | - Repositories       |
|     Data      | - DataSources + DTO  |
|               | - Storages           |
+---------------+----------------------+
```

**UI layer**: the entry point of your application and contains all the views. Presents data to the user and reacts to user input, and DOES NOT contain any business logic, instead observing the _ViewModels_ from the **Application layer** and sending actions back to them.

**Application layer**: coordinates between the UI and the deeper layers of the app through the **Domain layer**. Contains _ViewModels_ that expose state to the UI and handle user-driven actions, and _Services_ that carry out the main behaviors of the app, such as fetching data and applying transformations. This layer holds most of the business logic. (In a stricter Clean Architecture setup, business logic would live in the Domain layer, but that is not the case here.)

**Domain layer**: defines core data models and the interfaces for repositories that the Application layer depends on. The repository protocols abstract away the details of where the data comes from, whether it’s stored locally or fetched from a server. This layer serves mainly as a contract and model definition layer, staying independent of frameworks and external technologies.

**Data layer**: where implementation details live. Fulfills the repository interfaces defined in the **Domain layer** and connects to real data sources such as SwiftData, CoreData, REST APIs, or in-memory stores. Handles the conversion between domain models and external data formats using DTOs (Data Transfer Objects). This layer serves as the technical backend that the rest of the system depends on, but it remains isolated through the use of repository abstractions, meaning you can change how data is stored or retrieved without impacting the rest of your application logic.
