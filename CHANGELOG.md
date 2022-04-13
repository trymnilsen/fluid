## 2.0.0

> Note: This release has breaking changes.

This is a breaking release that mostly updates the `addListener` and `removeListener` logic for `Flow<T>`s.

- **`Flow`**
  - **BREAKING**: `Flow()` class has been made abstract with no `emit` method. Use a `ValueFlow` for emitting values now.
- **`Fluid`**
  - **BREAKING**: `valueNotifier()` method has been removed. Instead, use a `StreamFlow`.
  - **BREAKING**: `observe()` method has been removed. Instead, use a `StreamFlow`.

## 1.0.1

- Fixed issue with internal imports

## 1.0.0

- Initial release
