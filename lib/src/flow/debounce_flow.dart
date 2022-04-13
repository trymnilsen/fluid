import 'dart:async';

import 'package:fluid/src/flow/flow.dart';

class DebounceFlow<T> extends Flow<T> {
  final Flow<T> _source;
  final Duration _window;

  @override
  T get value => _source.value;

  Timer? _debounceTimer;

  DebounceFlow(
    this._source,
    this._window,
  );

  @override
  void onListen() {
    super.onListen();
    _source.addListener(_onFlowUpdate);
  }

  @override
  void onRemoveListeners() {
    super.onRemoveListeners();
    _source.removeListener(_onFlowUpdate);
  }

  void _onFlowUpdate() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(_window, () {
      notifyListeners();
    });
  }
}
