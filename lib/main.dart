import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/splash/splash_screen.dart';

void main() async {
  await initializeDateFormatting('in_ID', null)
      .then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scriptmatic App',
      home: const SplashScreen(),
    );
  }
}
