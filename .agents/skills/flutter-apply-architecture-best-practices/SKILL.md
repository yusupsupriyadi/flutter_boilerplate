---
name: flutter-apply-architecture-best-practices
description: Architects a Flutter application using the recommended layered approach (UI, Logic, Data) with Riverpod for state management and dependency injection. Use when structuring a new project or refactoring for scalability.
metadata:
  model: models/gemini-3.1-pro-preview
  last_modified: Sun, 05 Jul 2026 00:00:00 GMT
---
# Architecting Flutter Applications

> This project standardizes on **Riverpod** (with code generation) for state
> management and dependency injection. The layered philosophy below is
> unchanged from the classic MVVM approach — only the mechanism differs:
> ViewModels are Riverpod `Notifier`/`AsyncNotifier`s, and DI is done with
> `@riverpod` providers instead of `provider`/`get_it`.

## Contents
- [Architectural Layers](#architectural-layers)
- [Project Structure](#project-structure)
- [Workflow: Implementing a New Feature](#workflow-implementing-a-new-feature)
- [Examples](#examples)

## Architectural Layers

Enforce strict Separation of Concerns by dividing the application into distinct layers. Never mix UI rendering with business logic or data fetching.

### UI Layer (Presentation)
Implement an MVVM-style split where a Riverpod notifier plays the role of the ViewModel.
*   **Views:** Write reusable, lean widgets. A View is a `ConsumerWidget` (or `ConsumerStatefulWidget`) that reads state with `ref.watch(...)` and forwards user intent by calling methods on the notifier via `ref.read(provider.notifier)`. Restrict logic in Views to UI-specific operations (animations, layout, navigation).
*   **ViewModels (Notifiers):** Manage UI state and handle user interactions. Use a code-generated `@riverpod` class that extends `_$YourClass` and implements `build()`. Return a plain value for synchronous state, or a `Future`/`Stream` to expose an `AsyncValue` (loading / data / error) the View can pattern-match on. Depend on Repositories via `ref.watch(repositoryProvider)` — never construct them directly.

### Data Layer
Implement the Repository pattern to isolate data access logic and create a single source of truth.
*   **Services:** Create stateless classes to wrap external APIs (HTTP clients, local databases, platform plugins). Return raw API models. Expose them with a `@riverpod` provider.
*   **Repositories:** Consume one or more Services. Transform raw API models into clean Domain Models. Handle caching, offline synchronization, and retry logic. Expose Domain Models to notifiers, and expose the repository itself with a `@riverpod` provider.

### Logic Layer (Domain - Optional)
*   **Use Cases:** Implement this layer only if the application contains complex business logic that clutters the notifier, or if logic must be reused across multiple notifiers. Extract this logic into dedicated Use Case (interactor) classes (also exposed via `@riverpod`) that sit between notifiers and Repositories.

## Project Structure

Organize the codebase using a hybrid approach: group UI components by feature, group Data/Domain components by type, and keep cross-cutting infrastructure under `core/`.

```text
lib/
├── main.dart            # bootstrap: ProviderScope (+ overrides), runApp
├── app.dart             # root MaterialApp, theming
├── core/                # cross-cutting infrastructure
│   ├── config/          # environment config (envied)
│   ├── network/         # API client (Service), connectivity
│   ├── storage/         # secure storage, shared_preferences wrappers
│   ├── logging/         # logger wrapper
│   ├── error/           # typed exceptions / Result types
│   ├── theme/           # ThemeData
│   └── providers/       # global @riverpod providers for the above
├── data/
│   ├── models/          # API models (fromJson/toJson)
│   ├── repositories/    # Repository implementations (+ their providers)
│   └── services/        # additional API clients / local storage wrappers
├── domain/
│   ├── models/          # clean, immutable domain models
│   └── use_cases/       # optional business-logic classes
└── ui/
    ├── core/            # shared widgets, themes, typography
    └── features/
        └── [feature_name]/
            ├── view_models/   # @riverpod Notifier/AsyncNotifier
            └── views/         # ConsumerWidget screens
```

> **Generated provider names:** `riverpod_generator` drops a trailing
> `Notifier` from the class name — a class `PhotosNotifier` produces
> `photosProvider` (not `photosNotifierProvider`). A function `photoRepository`
> produces `photoRepositoryProvider`.

## Workflow: Implementing a New Feature

Follow this sequential workflow when adding a new feature. Copy the checklist to track progress.

### Task Progress
- [ ] **Step 1: Define Domain Models.** Create immutable data classes (plain classes with `==`/`hashCode`, or `freezed`).
- [ ] **Step 2: Implement Services.** Create/update Service classes for external API communication and expose each with a `@riverpod` provider.
- [ ] **Step 3: Implement Repositories.** Create the Repository to consume Services and return Domain Models; expose it with a `@riverpod` provider.
- [ ] **Step 4: Apply Conditional Logic (Domain Layer).**
  - *If the feature requires complex data transformation or cross-repository logic:* Create a Use Case class (with its own provider).
  - *If the feature is a simple CRUD operation:* Skip to Step 5.
- [ ] **Step 5: Implement the ViewModel.** Create a `@riverpod` `Notifier`/`AsyncNotifier`. Read dependencies via `ref.watch(...)`. Expose state and add command methods (using `AsyncValue.guard` for async mutations).
- [ ] **Step 6: Implement the View.** Create a `ConsumerWidget`. Read state with `ref.watch(provider)` and pattern-match on the `AsyncValue` (`switch` on `AsyncData`/`AsyncError`/loading).
- [ ] **Step 7: Wire Dependencies.** No manual DI container is needed — `@riverpod` providers are the DI graph. Ensure `main()` wraps the app in a `ProviderScope`, and override async singletons (e.g. `SharedPreferences`) there.
- [ ] **Step 8: Run Codegen & Validator.** Run `dart run build_runner build --delete-conflicting-outputs`, then unit tests for the notifier and repository.
  - *Feedback Loop:* Run tests → Review failures → Fix logic → Re-run until passing.

## Examples

### Data Layer: Service and Repository (with providers)

```dart
// 1. Service (raw API interaction), exposed via a provider.
class ApiClient {
  ApiClient(this._http);
  final http.Client _http;

  Future<UserApiModel> fetchUser(String id) async {
    // HTTP GET implementation...
  }
}

@riverpod
ApiClient apiClient(Ref ref) => ApiClient(http.Client());

// 2. Repository (single source of truth, returns Domain Model).
class UserRepository {
  UserRepository(this._apiClient);
  final ApiClient _apiClient;

  Future<User> getUser(String id) async {
    final apiModel = await _apiClient.fetchUser(id);
    return User(id: apiModel.id, name: apiModel.fullName); // -> Domain Model
  }
}

@riverpod
UserRepository userRepository(Ref ref) =>
    UserRepository(ref.watch(apiClientProvider));
```

### UI Layer: ViewModel (AsyncNotifier) and View (ConsumerWidget)

```dart
// 3. ViewModel: a code-generated AsyncNotifier. `profileProvider` is generated.
@riverpod
class Profile extends _$Profile {
  @override
  Future<User> build(String id) {
    return ref.watch(userRepositoryProvider).getUser(id);
  }

  Future<void> refresh(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(userRepositoryProvider).getUser(id),
    );
  }
}

// 4. View: a dumb UI component that watches the provider.
class ProfileView extends ConsumerWidget {
  const ProfileView({required this.id, super.key});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(profileProvider(id));
    return switch (userAsync) {
      AsyncData(:final value) => Column(
          children: [
            Text(value.name),
            ElevatedButton(
              onPressed: () => ref.read(profileProvider(id).notifier).refresh(id),
              child: const Text('Refresh'),
            ),
          ],
        ),
      AsyncError(:final error) => Center(child: Text('$error')),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}
```

### Testing notes
- Override providers in tests with `ProviderContainer(overrides: [repoProvider.overrideWithValue(mock)])` and `mocktail` mocks.
- Riverpod 3 auto-retries a failed provider (its state becomes `AsyncLoading` carrying the previous error). In tests, pass `retry: (_, _) => null` to `ProviderContainer` so a failed build settles into a terminal `AsyncError`.
