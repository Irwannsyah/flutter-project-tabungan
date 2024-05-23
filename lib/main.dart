import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_tabungan/auth/auth.dart';
import 'package:project_tabungan/auth/login_or_register.dart';
import 'package:project_tabungan/firebase_options.dart';
import 'package:project_tabungan/pages/home_pages.dart';
import 'package:project_tabungan/pages/profile_page.dart';
import 'package:project_tabungan/pages/user_page.dart';
import 'package:project_tabungan/theme/dark_mode.dart';
import 'package:project_tabungan/theme/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
        '/login_register_page':(context) => const LoginOrRegister(),
        '/home_page':(context) => const HomePage(),
        '/profile_page':(context) =>  ProfilPage(),
        '/user_page':(context) => const UserPage(),
      },
    );
  }
}
