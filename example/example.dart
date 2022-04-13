import 'dart:async';

import 'package:fluid/fluid.dart';
// Note the hide keyword in the import to avoid conficts
import 'package:flutter/material.dart' hide Flow;

void main() {
  // lets create a dependency that we need later
  final ourDependency = MyCoolDependency();
  // Here we create our container that can hold references to instances
  final container = SimpleFluidContainer();
  // We register our dependency with the container
  container.registerType(ourDependency);
  // Start the flutter app
  runApp(
    // The fluid resolver is responsible for holding our container and creating
    // [Fluids] from the [FluidBuilder] widget
    FluidResolver(
      container: container,
      child: MaterialApp(
        home: Scaffold(
          // The fluidbuilder will build give us the build context and the fluid we need
          body: FluidBuilder<HomeFluid>(
            builder: (context, fluid) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Then we can use a [FlowBuilder] to rebuild the child when
                    // data is emitted to the flow. This will always start with
                    // data from the first frame.
                    FlowBuilder<String>(
                      flow: fluid.greetingFlow,
                      builder: (context, value) {
                        return Text(value);
                      },
                    ),

                    // We will also print out the value of flow we have mapped
                    // in our fluid
                    FlowBuilder<int>(
                      flow: fluid.lengthOfGreeting,
                      builder: (context, value) {
                        return Text("Length of greeting: $value");
                      },
                    ),
                  ],
                ),
              );
            },
            // The fluid factory is imporant to know how to create our fluid.
            // here we also provide it with data (the name Alex) from our UI.
            fluidFactory: HomeFluidFactory("Alex"),
          ),
        ),
      ),
    ),
  );
}

/// Factories are needed to both be able to provide data from the UI and retrieve
/// dependencies from "the outside". In [createFluid] we will get access to the
/// container we created before we started our app with [runApp].
class HomeFluidFactory extends FluidFactory<HomeFluid> {
  /// We will keep the name in field so it can be used when [createFluid] is
  /// called
  final String name;
  HomeFluidFactory(this.name);
  @override
  HomeFluid createFluid(FluidContainer container) {
    // Return an instance of the [HomeFluid], we can use the container to get
    // the instance of the [MyCoolDependency]
    return HomeFluid(container.getInstance<MyCoolDependency>(), name);
  }
}

/// This is the logical component that holds our data and has the ability to get
/// dependencies from outside the widget tree we defined in the container
class HomeFluid extends Fluid {
  late final Flow<String> greetingFlow;
  late final Flow<int> lengthOfGreeting;
  final String name;

  /// Creates a new HomeFluid, notice the dependency both on the
  /// [MyCoolDependency] and the name from a String
  HomeFluid(MyCoolDependency helloDependency, this.name) {
    final valueFlow = ValueFlow("Hi! I'm loading");
    greetingFlow = valueFlow;
    // Lets create a flow that maps the greeting into the length of it
    lengthOfGreeting = valueFlow.map(
      (value) => value.length,
    );
    // Load the hello from our dependency in a microtask and then update
    // the greeting text. The length of the greeting will automatically be updated
    scheduleMicrotask(() async {
      final greeting = await helloDependency.sayHello(name);
      valueFlow.emit(greeting);
    });
  }
}

/// A generic class that has no knowledge of flutter. It might be our API,
/// a class that fetches something from storage or anything else really that
/// we don't want to have tied to our widgets/view
class MyCoolDependency {
  Future<String> sayHello(String name) async {
    // Simulate a delay from an api
    await Future.delayed(const Duration(seconds: 2));
    return "Hellooo $name";
  }
}
