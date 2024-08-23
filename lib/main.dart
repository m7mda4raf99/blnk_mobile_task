import 'package:blnk_mobile_task/presentation/screens/registration_screen.dart';
import 'package:blnk_mobile_task/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BLNK Mobile Task',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/': (context) => RegistrationScreen(),
      },
    );
  }
}
