import 'package:flutter/material.dart';
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
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF181818),
          foregroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      // initialRoute: username == null ? WelcomeScreen.id : HomeScreen.id,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        AddTask.id: (context) => AddTask(),
      },
    );
  }
}
