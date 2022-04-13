import 'dart:async';

import 'package:fluid/src/flow/value_flow.dart';

class StreamFlow<T> extends ValueFlow<T> {
  StreamSubscription<T>? _streamSubscription;
  final Stream<T> stream;
  StreamFlow(
    this.stream,
    T initialValue,
  ) : super(initialValue);

  @override
  void onListen() {
    _streamSubscription = stream.listen(emit);
    super.onListen();
  }

  @override
  void onRemoveListeners() {
    _streamSubscription?.cancel();
    super.onRemoveListeners();
  }
}
