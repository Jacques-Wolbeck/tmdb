import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'widgets/custom/custom_page_route.dart';

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/home_screen':
    default:
      return CustomPageRoute(child: const HomeScreen());
  }
}
