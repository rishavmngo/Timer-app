import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timer_app/auth/auth_gate.dart';
import 'package:timer_app/firebase_options.dart';
import 'package:timer_app/theme.dart';

void main() async {
//Logger.debug = (String message) => print(message); // Output logs to console

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).primaryColor, // Color of you choice
          statusBarIconBrightness: Brightness.light,
        ),
        child: MaterialApp(
            theme: lightTheme,
            debugShowCheckedModeBanner: false,
            home: const AuthGate()));
  }
}
