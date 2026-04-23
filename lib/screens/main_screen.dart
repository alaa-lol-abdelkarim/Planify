import 'package:flutter/material.dart';
import 'package:planify/constants.dart';
import 'package:planify/screens/completed_tasks_screen.dart';
import 'package:planify/screens/home_screen.dart';
import 'package:planify/screens/profile_screen.dart';
import 'package:planify/screens/tasks_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  static const String id = 'main_screen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _screens = [
    HomeScreen(),
    TasksScreen(),
    CompletedTasksScreen(),
    ProfileScreen(),
  ];

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: kDarkModeScreenColor,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kBottomColor,
        unselectedItemColor: Color(0xFFC6C6C6),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'ToDo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_add_check_rounded),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
          ),
        ],
      ),
      body: _screens[_selectedIndex],
    );
  }
}
