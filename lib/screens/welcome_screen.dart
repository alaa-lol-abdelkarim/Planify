import 'package:flutter/material.dart';
import 'package:planify/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  static const String id = 'welcome_screen';
  // final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff181818),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              children: [
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/images/app_logo.png'),
                      width: 42,
                      height: 42,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Planify',
                      style: TextStyle(color: Color(0xffffffff), fontSize: 28),
                    ),
                  ],
                ),
                SizedBox(height: 100),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome to Planify',
                      style: TextStyle(
                        color: Color(0xffffffff),
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 8),
                    SvgPicture.asset('assets/images/waving_hand.svg'),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'Your productivity journey starts here.',
                  style: kTextStyle,
                ),
                SizedBox(height: 24),
                SvgPicture.asset('assets/images/pana.svg'),
                SizedBox(height: 24),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Full Name', style: kTextStyle),
                      SizedBox(height: 8),
                      TextFormField(
                        // controller: controller,
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your name.';
                          }
                          return null;
                        },
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: kTextFieldDecoration,
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // backgroundColor: Color(0xff212121),
                          backgroundColor: Color(0xFF15B86C),
                          foregroundColor: Color(0xFFFFFCFC),
                          fixedSize: Size(
                            MediaQuery.of(context).size.width,
                            40,
                          ),
                        ),
                        onPressed: () {
                          if (_key.currentState?.validate() ?? false) {
                            Navigator.pushNamed(context, HomeScreen.id);
                          }
                        },
                        child: Text('Get Started'),
                      ),
                    ],
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
