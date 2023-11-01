import 'package:ff_annotation_route_library/ff_annotation_route_library.dart';
import 'package:flutter/material.dart';
import 'package:taller/src/presentation/unknown/unknow_page.dart';
import 'package:taller/src/routes/taller_route.dart';

mixin RouteMiddleware {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static Route generateRoute(RouteSettings settings) {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    return onGenerateRoute(
      settings: settings,
      notFoundPageBuilder: () => const UnknownPage(),
      getRouteSettings: getRouteSettings,
    );
  }
}
