## 2.1.3

- Don't dispose fluids without a factory function

## 2.1.2

- Dont make the `fluidFactory` parameter of `FluidBuilder` required

## 2.1.1

- Only add an internal `_FluidWidget` if factory is set

## 2.1.0

- The `fluidFactory` parameter for a `FluidBuilder` can now be set to null. If this parameter is null, the builder will attempt to resolve the fluid based on possible ancestor builders of the same type.

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
