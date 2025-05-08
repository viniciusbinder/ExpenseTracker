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

This architecture separates responsibilities across four layers. The **UI layer** stays free of business logic and simply displays state and sends back actions. The **Application layer** handles most behaviors, it reacts to user input through _ViewModels_ and bridges them with dependencies through _Services_. The **Data layer** implements access to databases and APIs, and the conversion between external formats and internal models. Dictating all of it is the **Domain layer**, which defines the heart of the app. It acts as a stable bridge between the Application and Data layers by exposing the core models to be used and the interfaces for data access (like repositories). In this example project, business rules are applied in the _Services_ and not the Domain layer like in other common cases.

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
