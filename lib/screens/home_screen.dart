import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planify/constants.dart';
import 'welcome_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff181818),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: AssetImage('assets/images/avatar.png'),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Good Evening, Alaa', style: kTextStyle),
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
                Row(
                  children: [
                    Text(
                      'Yuhuu ,Your work Is almost done !',
                      style: kTextStyle.copyWith(fontSize: 20),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
