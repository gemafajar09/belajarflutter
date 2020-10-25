import 'package:klinkmediatama/koneksiterputus.dart';
import 'package:klinkmediatama/login/login.dart';
import 'package:klinkmediatama/src/pages/BookingJadwal.dart';
import 'package:klinkmediatama/src/pages/detail_artikel.dart';
import 'package:flutter/material.dart';
import 'package:klinkmediatama/src/pages/detail_page.dart';
import 'package:klinkmediatama/src/pages/home_page.dart';
import 'package:klinkmediatama/src/pages/nokoneksi.dart';
import 'package:klinkmediatama/src/pages/splash_page.dart';
import 'package:klinkmediatama/src/widgets/coustom_route.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/': (_) => Login(),
      '/spalsh': (_) => SplashPage(),
      '/HomePage': (_) => HomePage(),
      '/NoKoneksi': (_) => Koneksiterputus(),
    };
  }

  static Route onGenerateRoute(RouteSettings settings) {
    final List<String> pathElements = settings.name.split('/');
    if (pathElements[0] != '' || pathElements.length == 1) {
      return null;
    }
    switch (pathElements[1]) {
      case "DetailPage":
        return CustomRoute<bool>(
            builder: (BuildContext context) => DetailPage(
                  model: settings.arguments,
                ));
      case "DetailArtikel":
        return CustomRoute<bool>(
            builder: (BuildContext context) => DetailArtikel(
                  artikel: settings.arguments,
                ));
      case "BookingJadwal":
        return CustomRoute<bool>(
            builder: (BuildContext context) => BookingJadwal(
                  model: settings.arguments,
                ));
    }
  }
}
