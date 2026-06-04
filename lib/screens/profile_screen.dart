import 'package:flutter/material.dart';
import 'package:planify/screens/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = '';
  bool isDarkMode = true;

  void _loadUsername() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      username = pref.getString('username') ?? 'User';
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Profile")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage(
                            'assets/images/person.png',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF282828),
                            ),
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Color(0xFFFFFCFC),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      username,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffffffff),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'One task at a time. One step closer.',
                      style: TextStyle(fontSize: 14, color: Color(0xffC6C6C6)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Profile Info',
                style: TextStyle(fontSize: 20, color: Color(0xffffffff)),
              ),
              SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.person_outline, color: Color(0xffC6C6C6)),
                title: Text(
                  'User Details',
                  style: TextStyle(fontSize: 16, color: Color(0xffffffff)),
                ),
                trailing: Icon(Icons.arrow_forward, color: Color(0xffC6C6C6)),
              ),
              Divider(color: Color(0xff6E6E6E)),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.dark_mode_outlined,
                  color: Color(0xffC6C6C6),
                ),
                title: Text(
                  'Dark Mode',
                  style: TextStyle(fontSize: 16, color: Color(0xffffffff)),
                ),
                trailing: Switch.adaptive(
                  value: isDarkMode,
                  onChanged: (bool value) {
                    setState(() {
                      isDarkMode = value;
                    });
                  },
                ),
              ),
              Divider(color: Color(0xff6E6E6E)),
              ListTile(
                onTap: () async {
                  final pref = await SharedPreferences.getInstance();
                  await pref.clear();
                  if (!mounted) return;
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    WelcomeScreen.id,
                    (route) => false,
                  );
                },
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.logout_outlined, color: Color(0xffC6C6C6)),
                title: Text(
                  'Log out',
                  style: TextStyle(fontSize: 16, color: Color(0xffffffff)),
                ),
                trailing: Icon(Icons.arrow_forward, color: Color(0xffC6C6C6)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
