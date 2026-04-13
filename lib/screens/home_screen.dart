import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planify/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username = 'Default';
  List<dynamic> task = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loadUsername();
    _loadTask();
  }

  void _loadUsername() async {
    final pref = await SharedPreferences.getInstance();
    username = pref.getString('username');
    setState(() {});

    print('username = $username');
  }

  void _loadTask() async {
    final pref = await SharedPreferences.getInstance();
    final finalTask = pref.getString('task');
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      setState(() {
        task = taskAfterDecode;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkModeScreenColor,
      floatingActionButton: SizedBox(
        height: 40,
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, AddTask.id);
          },
          backgroundColor: kBottomColor,
          foregroundColor: Colors.white,
          icon: Icon(Icons.add),
          label: Text('Add New Task'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 24,
                    child: SvgPicture.asset('assets/images/avatar.svg'),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Good Evening, $username', style: kTextStyle),
                      Text(
                        'One task at a time.One step closer.',
                        style: kTextStyle.copyWith(
                          fontSize: 14,
                          color: Color(0xffC6C6C6),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.wb_sunny_outlined, color: Colors.white),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Yuhuu ,Your work Is',
                style: kTextStyle.copyWith(fontSize: 32),
              ),
              Row(
                children: [
                  Text(
                    'almost done !',
                    style: kTextStyle.copyWith(fontSize: 32),
                  ),
                  SizedBox(width: 8),
                  SvgPicture.asset('assets/images/waving_hand.svg'),
                ],
              ),
              SizedBox(height: 16),
              Card(
                color: Color(0xff282828),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Achieved Tasks', style: kTextStyle),
                          Text(
                            '3 Out of 6 Done',
                            style: kTextStyle.copyWith(
                              fontSize: 14,
                              color: Color(0xffC6C6C6),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Spacer(),
              // Align(
              //   alignment: Alignment.bottomRight,
              //   child: ElevatedButton.icon(
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: kBottomColor,
              //       foregroundColor: Color(0xFFFFFCFC),
              //     ),
              //     icon: Icon(Icons.add),
              //     label: Text('Add New Task'),
              //     onPressed: () {
              //       Navigator.pushNamed(context, AddTask.id);
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
