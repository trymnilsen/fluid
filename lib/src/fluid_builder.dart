import 'package:fluid/src/fluid.dart';
import 'package:fluid/src/fluid_factory.dart';
import 'package:fluid/src/fluid_resolver.dart';
import 'package:flutter/widgets.dart';

/// The build function for child widgets of a [FluidBuilder]
typedef FluidChildBuilder<T extends Fluid> = Widget Function(
  BuildContext context,
  T fluid,
);

/// A build widget for creating and providing a [Fluid] to child widgets
class FluidBuilder<T extends Fluid> extends StatefulWidget {
  final FluidFactory<T> fluidFactory;
  final FluidChildBuilder<T> builder;

  /// Creates a [FluidBuilder] using the given [FluidFactory] and provides it to
  /// the [FluidChildBuilder].
  const FluidBuilder({
    required this.builder,
    required this.fluidFactory,
    Key? key,
  }) : super(key: key);

  @override
  State<FluidBuilder<T>> createState() => _FluidBuilderState<T>();
}

class _FluidBuilderState<T extends Fluid> extends State<FluidBuilder<T>> {
  late T fluid;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final fluidResolver = FluidResolver.of(context);
    fluid = fluidResolver.getFluid(widget.fluidFactory);
  }

  @override
  void dispose() {
    fluid.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final child = widget.builder(context, fluid);
    return child;
  }
}
