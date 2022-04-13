import 'package:fluid/fluid.dart';

class TestableFlow<T> extends ValueFlow<T> {
  final Function onListenCallback;
  final Function onStopListenCallback;

  TestableFlow(
    T value,
    this.onListenCallback,
    this.onStopListenCallback,
  ) : super(value);

  @override
  void onListen() {
    super.onListen();
    onListenCallback();
  }

  @override
  void onRemoveListeners() {
    super.onRemoveListeners();
    onStopListenCallback();
  }
}
