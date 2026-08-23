import 'package:angel3_container/mirrors.dart';
import 'package:angel3_production/angel3_production.dart';
import 'package:starter_app/starter_app.dart';

// NOTE: By default, the Runner class does not use the `MirrorsReflector`, or any
// reflector, by default.
//
// If your application is using any sort of functionality reliant on annotations or reflection,
// either include the MirrorsReflector, or use a static reflector variant.
//
// The following use cases require reflection:
// * Use of Controllers, via @Expose() or @ExposeWS()
// * Use of dependency injection into constructors, whether in controllers or plain `container.make` calls
// * Use of the `ioc` function in any route
//
// The `MirrorsReflector` from `package:angel3_container/mirrors.dart` is by far the most convenient pattern,
// so use it if possible.
//
// However, the following alternatives exist:
// * Generation via `package:angel3_container_generator`
// * Creating an instance of `StaticReflector`
// * Manually implementing the `Reflector` interface (cumbersome; not recommended)
void main(List<String> args) => Runner(
  'Starter App',
  configureServer,
  reflector: MirrorsReflector(),
).run(args);
