/// Base fluid class
///
/// Fluids are the building blocks for providing logic to your widgets.
/// It is similar to the concept of a viewmodel, but to avoid any expectations
/// from a viewmodel pattern it has its own name and should be considers as
/// logical components referenced by the view (your widgets). It might contain
/// specific logic itself in the future
abstract class Fluid {
  /// Dispose any resources held by this fluid
  void dispose() {}
}
