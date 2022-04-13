import 'package:fluid/src/fluid.dart';
import 'package:fluid/src/fluid_container.dart';

/// Fluid factories are responsible for creating fluids. They are the glue
/// between arguments and the logic to create them.
abstract class FluidFactory<T extends Fluid> {
  /// Create the fluid for this factory. This method is invoked by the
  /// [FluidResolver] and the [FluidContainer] is provided by the resolver.
  T createFluid(FluidContainer container);
}
