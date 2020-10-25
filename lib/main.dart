import 'package:flutter/material.dart';

import 'package:klinkmediatama/src/config/route.dart';
import 'package:klinkmediatama/src/theme/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Antrina Klinik',
      theme: AppTheme.lightTheme,
      routes: Routes.getRoute(),
      onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
      debugShowCheckedModeBanner: false,
      initialRoute: "SplashPage",
    );
  }
}
