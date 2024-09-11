import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timer_app/auth/auth_gate.dart';
import 'package:timer_app/theme.dart';
import 'package:timer_app/utils/local_storage.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
//Logger.debug = (String message) => print(message); // Output logs to console

  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.get("URL"),
    anonKey: dotenv.get("KEY"),
  );
  runApp(ProviderScope(overrides: [
    sharedPreferencesProvider.overrideWithValue(prefs),
  ], child: const MyApp()));
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
            builder: FToastBuilder(),
            navigatorKey: navigatorKey,
            theme: lightTheme,
            debugShowCheckedModeBanner: false,
            home: const AuthGate()));
  }
}
