import 'package:flutter/foundation.dart';

/// Flows are synchronous streams of data. They are named [Flows] as they are
/// mostly used in [Fluids] (but this is not a requirement) and lets the fluid
/// data flow down into the view. Flows always has a value.
abstract class Flow<T> with ChangeNotifier {
  /// The current value held by this flow
  T get value;

  Flow();

  @override
  void addListener(VoidCallback listener) {
    if (!hasListeners) {
      onListen();
    }
    super.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    super.removeListener(listener);
    if (!hasListeners) {
      onRemoveListeners();
    }
  }

  @protected
  void onListen() {}

  @protected
  void onRemoveListeners() {}
}
