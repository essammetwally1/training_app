import 'package:flutter/material.dart';
import 'package:training_app/auth/auth_screen.dart';
import 'package:training_app/onboarding/onboarding_scree.dart';
import 'package:training_app/screens/home_screen.dart';

void main() {
  runApp(TrainingApp());
}

class TrainingApp extends StatelessWidget {
  const TrainingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: OnboardingScreen.routeName,
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            overlayColor: WidgetStateProperty.all(Colors.transparent),
          ),
        ),
      ),
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        AuthScreen.routeName: (context) => AuthScreen(),
        OnboardingScreen.routeName: (context) => OnboardingScreen(),
      },
    );
  }
}
