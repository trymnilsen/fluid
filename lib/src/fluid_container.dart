/// A fluid container is a map of dependencies that can be resolved by a [FluidFactory].
/// a simple type-based container is provided with [SimpleFluidContainer].
abstract class FluidContainer {
  T getInstance<T>();
}

/// Holds a reference to dependencies in a map and allows fetching them with
/// their type. As type is the only qualifier it does not support multiple instances
/// of the same type.
class SimpleFluidContainer extends FluidContainer {
  final Map<Type, dynamic> instances = {};
  @override
  T getInstance<T>() {
    if (instances.containsKey(T)) {
      return instances[T] as T;
    } else {
      throw ArgumentError("Type $T is not registered");
    }
  }

  void registerType<T>(T instance) {
    instances[T] = instance;
  }
}
