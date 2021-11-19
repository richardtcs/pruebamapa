import 'package:flutter/cupertino.dart';
import 'package:mapsprueba1/app/domain/ui/capas/home/home_page.dart';
import 'package:mapsprueba1/app/domain/ui/pages/request_permission/location_permission_page.dart';
import 'package:mapsprueba1/app/domain/ui/pages/splash/splash_page.dart';
import 'package:mapsprueba1/app/domain/ui/routes/routes.dart';

Map<String, Widget Function(BuildContext)> appRoutes() {
  return {
    Routes.SPLASH: (_) => const SplashPage(),
    Routes.PERMISSIONS: (_) => const RequestPermissionPage(),
    Routes.HOME: (_) => HomePage(),
  };
}