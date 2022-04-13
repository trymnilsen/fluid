import 'package:fluid/src/flow/flow.dart';
import 'package:flutter/widgets.dart' hide Flow;

typedef FlowWidgetBuilder<T> = Widget Function(BuildContext context, T value);

/// A widget that rebuilds when the [flow] emits new values
class FlowBuilder<T> extends StatefulWidget {
  final Flow<T> flow;
  final FlowWidgetBuilder<T> builder;

  /// Create a new flow builder that rebuilds when the [flow] emits a value.
  /// The value is provided to the [builder] function.
  const FlowBuilder({
    required this.flow,
    required this.builder,
    Key? key,
  }) : super(key: key);

  @override
  State<FlowBuilder> createState() => _FlowBuilderState<T>();
}

class _FlowBuilderState<T> extends State<FlowBuilder<T>> {
  late T _value;
  @override
  void initState() {
    super.initState();
    _value = widget.flow.value;
    widget.flow.addListener(_flowUpdated);
  }

  @override
  void dispose() {
    widget.flow.removeListener(_flowUpdated);
    super.dispose();
  }

  void _flowUpdated() {
    setState(() {
      _value = widget.flow.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _value);
  }
}
