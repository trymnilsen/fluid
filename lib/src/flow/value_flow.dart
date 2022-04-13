import 'package:fluid/src/flow/flow.dart';

/// A [ValueFlow] is a [Flow] that holds a value that can be updated with the [emit] method.
class ValueFlow<T> extends Flow<T> {
  T _value;

  /// Create new [ValueFlow] that has a set initial value.
  ValueFlow(this._value);

  void emit(T newValue) {
    _value = newValue;
    notifyListeners();
  }

  @override
  T get value => _value;
}
