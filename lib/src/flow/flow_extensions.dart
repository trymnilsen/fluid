import 'package:fluid/src/flow/debounce_flow.dart';
import 'package:fluid/src/flow/distinct_flow.dart';
import 'package:fluid/src/flow/flow.dart';
import 'package:fluid/src/flow/mapping_flow.dart';
import 'package:fluid/src/flow/stream_flow.dart';

extension FlowExtensions<T> on Flow<T> {
  /// Return a new flow that maps from this [flow]'s type to another type using
  /// [mapper] function.
  Flow<T2> map<T2>(FlowMapper<T, T2> mapper) {
    return MappingFlow(this, mapper);
  }

  /// Return a new flow that only emits values after [window] time has passed.
  Flow<T> debounce(Duration window) {
    return DebounceFlow(this, window);
  }

  /// Return a new flow that only emits values that are considered different
  /// using the `==` operator of the type
  Flow<T> distinct() {
    return DistinctFlow(this);
  }
}

extension StreamExtension<T> on Stream<T> {
  /// Create a flow that listens for updates from this stream. Requires an initial value.
  /// Only emits successful values from the stream.
  Flow<T> asFlow(T initialValue) {
    return StreamFlow(this, initialValue);
  }
}
