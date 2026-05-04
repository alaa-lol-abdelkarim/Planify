import 'package:flutter/material.dart';
import 'package:planify/constants.dart';
import 'package:planify/screens/main_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/home_screen.dart';
import 'screens/add_task_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pref = await SharedPreferences.getInstance();
  String? username = pref.getString('username');

  runApp(MyApp(username: username));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.username});

  final String? username;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Planify',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: kDarkModeScreenColor,
        appBarTheme: AppBarTheme(
          backgroundColor: kDarkModeScreenColor,
          foregroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      initialRoute: username == null ? WelcomeScreen.id : MainScreen.id,
      // initialRoute: MainScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        AddTask.id: (context) => AddTask(),
        MainScreen.id: (context) => MainScreen(),
      },
    );
  }
}
