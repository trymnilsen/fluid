import 'package:fluid/src/flow/flow.dart';

/// A flow that only emits values that are not considered equal using the `==` operator.
class DistinctFlow<T> extends Flow<T> {
  final Flow<T> _source;
  T? _previousSourceValue;

  @override
  T get value => _source.value;

  DistinctFlow(this._source);

  void _onFlowUpdate() {
    if (_previousSourceValue == _source.value) {
      return;
    } else {
      _previousSourceValue = _source.value;
      notifyListeners();
    }
  }

  @override
  void onListen() {
    super.onListen();
    _source.addListener(_onFlowUpdate);
  }

  @override
  void onRemoveListeners() {
    super.onRemoveListeners();
    _source.addListener(_onFlowUpdate);
  }
}
