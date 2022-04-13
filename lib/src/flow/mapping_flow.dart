import 'package:fluid/src/flow/flow.dart';

/// A function used to map from one flow to another
typedef FlowMapper<T, T2> = T2 Function(T value);

/// A flow that will map a value from one type to another type
class MappingFlow<T, T2> extends Flow<T2> {
  final Flow<T> _source;
  final FlowMapper<T, T2> _mapper;

  @override
  T2 get value => _mapper(_source.value);

  /// Create a [Flow] that maps the value in the [source] flow using the [mapper] function.
  MappingFlow(
    this._source,
    this._mapper,
  );

  @override
  void onListen() {
    super.onListen();
    _source.addListener(_onUpdate);
  }

  @override
  void onRemoveListeners() {
    super.onRemoveListeners();
    _source.removeListener(_onUpdate);
  }

  void _onUpdate() {
    notifyListeners();
  }
}
