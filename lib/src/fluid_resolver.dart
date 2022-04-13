import 'package:fluid/src/fluid.dart';
import 'package:fluid/src/fluid_container.dart';
import 'package:fluid/src/fluid_factory.dart';
import 'package:flutter/widgets.dart';

/// Inherited widget that holds the [FluidContainer] configured and the logic
/// for using fluid factories
class FluidResolver extends InheritedWidget {
  final FluidContainer container;

  /// Create new fluid resolver
  const FluidResolver({
    required this.container,
    required Widget child,
    Key? key,
  }) : super(
          child: child,
          key: key,
        );

  /// Retrieve a fluid and create it with the given [FluidFactory].
  /// Will create a new fluid each time it is called
  T getFluid<T extends Fluid>(FluidFactory<T> fluidFactory) {
    return fluidFactory.createFluid(container);
  }

  /// Retrieve the fluid resolver from the [BuildContext]
  static FluidResolver of(BuildContext buildContext) {
    final resolver =
        buildContext.dependOnInheritedWidgetOfExactType<FluidResolver>();

    if (resolver == null) {
      throw FlutterError("No FluidResolver found in context");
    }

    return resolver;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    if (oldWidget is FluidResolver) {
      return oldWidget.container != container;
    } else {
      return true;
    }
  }
}
