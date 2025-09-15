import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/auth/auth_screen.dart';
import 'package:training_app/onboarding/onboarding_screen.dart';
import 'package:training_app/provider/user_provider.dart';
import 'package:training_app/screens/profile_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: TrainingApp(),
    ),
  );
}

class TrainingApp extends StatelessWidget {
  const TrainingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
        ProfileScreen.routeName: (context) => ProfileScreen(),
        AuthScreen.routeName: (context) => AuthScreen(),
        OnboardingScreen.routeName: (context) => OnboardingScreen(),
      },
      initialRoute: OnboardingScreen.routeName,
    );
  }
}
