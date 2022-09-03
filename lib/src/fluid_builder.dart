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
  final FluidFactory<T>? fluidFactory;
  final FluidChildBuilder<T> builder;

  /// Creates a [FluidBuilder] using the given [FluidFactory] and provides it to
  /// the [FluidChildBuilder]. If the [FluidFactory] is null the closest
  /// fluid ancestor of the same type will be used
  const FluidBuilder({
    required this.builder,
    this.fluidFactory,
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
    final factoryFunction = widget.fluidFactory;
    if (factoryFunction != null) {
      // A factory function was provided, use it to create the
      // fluid for this builder
      final fluidResolver = FluidResolver.of(context);
      fluid = fluidResolver.getFluid(factoryFunction);
    } else {
      // No factory was provided, attempt to find the closest
      // Fluid Widget
      final fluidWidget = _FluidWidget.of<T>(context);
      fluid = fluidWidget.fluid;
    }
  }

  @override
  void dispose() {
    if (widget.fluidFactory != null) {
      fluid.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final child = widget.builder(context, fluid);
    if (widget.fluidFactory != null) {
      return _FluidWidget(
        fluid: fluid,
        child: child,
      );
    } else {
      return child;
    }
  }
}

class _FluidWidget<T extends Fluid> extends InheritedWidget {
  final T fluid;

  const _FluidWidget({
    required this.fluid,
    required super.child,
    super.key,
  });

  /// Retrieve the fluid resolver from the [BuildContext]
  static _FluidWidget<T2> of<T2 extends Fluid>(BuildContext buildContext) {
    final fluidWidget =
        buildContext.dependOnInheritedWidgetOfExactType<_FluidWidget<T2>>();

    if (fluidWidget == null) {
      throw FlutterError(
        "No fluid ancestor was found for type $T2. Have you forgotten to add a FluidBuilder parent with a factory?",
      );
    }

    return fluidWidget;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    if (oldWidget is _FluidWidget<T>) {
      return oldWidget.fluid != fluid;
    } else {
      return true;
    }
  }
}
