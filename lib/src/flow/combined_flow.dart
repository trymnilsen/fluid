import 'package:fluid/src/flow/flow.dart';

typedef Combiner<T> = T Function(List<Flow<dynamic>> items);

/// A flow that combines different streams. See the [CombinedFlow.combineTwo]
/// static methods from helper functions that provides type safety
class CombinedFlow<T> extends Flow<T> {
  final Combiner _combiner;
  final List<Flow> _flows;

  @override
  T get value => _combiner(_flows);

  CombinedFlow(this._flows, this._combiner);

  void _flowUpdated() {
    notifyListeners();
  }

  @override
  void onListen() {
    super.onListen();
    for (final flow in _flows) {
      flow.addListener(_flowUpdated);
    }
  }

  @override
  void onRemoveListeners() {
    super.onRemoveListeners();
    for (final flow in _flows) {
      flow.removeListener(_flowUpdated);
    }
  }

  static CombinedFlow<R> combineTwo<R, F1, F2>(
    Flow<F1> f1,
    Flow<F2> f2,
    R Function(F1 a, F2 b) combiner,
  ) {
    listCombiner(List<dynamic> items) {
      return combiner(
        (items[0] as Flow<F1>).value,
        (items[1] as Flow<F2>).value,
      );
    }

    return CombinedFlow<R>(
      [f1, f2],
      listCombiner,
    );
  }

  static CombinedFlow<R> combineThree<R, F1, F2, F3>(
    Flow<F1> f1,
    Flow<F2> f2,
    Flow<F3> f3,
    R Function(F1 a, F2 b, F3 c) combiner,
  ) {
    listCombiner(List<dynamic> items) {
      return combiner(
        (items[0] as Flow<F1>).value,
        (items[1] as Flow<F2>).value,
        (items[2] as Flow<F3>).value,
      );
    }

    return CombinedFlow<R>(
      [f1, f2, f3],
      listCombiner,
    );
  }

  static CombinedFlow<R> combineFour<R, F1, F2, F3, F4>(
    Flow<F1> f1,
    Flow<F2> f2,
    Flow<F3> f3,
    Flow<F4> f4,
    R Function(F1 a, F2 b, F3 c, F4 d) combiner,
  ) {
    listCombiner(List<dynamic> items) {
      return combiner(
        (items[0] as Flow<F1>).value,
        (items[1] as Flow<F2>).value,
        (items[2] as Flow<F3>).value,
        (items[3] as Flow<F4>).value,
      );
    }

    return CombinedFlow<R>(
      [f1, f2, f3],
      listCombiner,
    );
  }
}
