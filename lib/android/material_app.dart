import 'package:flutter/material.dart';
import 'package:tmdb/android/routes.dart';
import 'package:tmdb/android/screens/splash_screen.dart';
import 'package:tmdb/android/widgets/custom/custom_text_theme.dart';

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TMDb',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
        textTheme: CustomTextTheme(),
      ),
      onGenerateRoute: (route) => onGenerateRoute(route),
      home: const SplashScreen(),
    );
  }
}
