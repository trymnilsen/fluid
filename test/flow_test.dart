import 'package:fluid/src/flow/flow_extensions.dart';
import 'package:fluid/src/flow/value_flow.dart';
import 'package:flutter_test/flutter_test.dart';

import 'testable_flow.dart';

void main() {
  test('Value is emitted', () {
    final valueFlow = ValueFlow("hello");
    String? updatedValue;
    valueFlow.addListener(() {
      updatedValue = valueFlow.value;
    });

    valueFlow.emit("hi!");
    expect(updatedValue, "hi!");
  });

  test('Callback is called on listener change', () {
    var onListenCalledTimes = 0;
    var onStopListenCalledTimes = 0;
    final testFlow = TestableFlow("first!", () {
      onListenCalledTimes++;
    }, () {
      onStopListenCalledTimes++;
    });

    firstListener() {}
    secondListener() {}

    testFlow.addListener(firstListener);
    testFlow.addListener(secondListener);

    testFlow.removeListener(firstListener);
    testFlow.removeListener(secondListener);

    testFlow.addListener(firstListener);
    testFlow.removeListener(firstListener);

    testFlow.addListener(firstListener);
    testFlow.addListener(secondListener);
    testFlow.removeListener(firstListener);

    expect(onListenCalledTimes, 3);
    expect(onStopListenCalledTimes, 2);
  });

  test('nested flows are not invoked on cleared listeners', () {
    final valueFlow = ValueFlow("just a hafling");
    final isDragonFlow = valueFlow.map((value) => value == "dragons!");
    final isGoblinFlow = valueFlow.map((value) => value == "goblins!");
    var numberOfDragons = 0;
    var numberOfGoblins = 0;

    dragonsListener() {
      if (isDragonFlow.value) {
        numberOfDragons++;
      }
    }

    goblinsListener() {
      if (isGoblinFlow.value) {
        numberOfGoblins++;
      }
    }

    isDragonFlow.addListener(dragonsListener);
    isGoblinFlow.addListener(goblinsListener);

    valueFlow.emit("dragons!");
    valueFlow.emit("goblins!");

    isGoblinFlow.removeListener(goblinsListener);

    valueFlow.emit("skeletons!");
    valueFlow.emit("goblins!");
    valueFlow.emit("dragons!");

    expect(numberOfDragons, 2);
    expect(numberOfGoblins, 1);
  });
}
