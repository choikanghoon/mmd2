import 'package:flutter/material.dart';
import 'screens/log_in.dart';
import 'screens/main_screen.dart';
import 'state_bar/appbar_screen.dart';
import 'state_bar/bottom_screen.dart';
import 'state_bar/menu.dart';
import 'screens/login_screen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appbar',
      debugShowCheckedModeBanner: false,
      home: MyPage(),
    );
  }
}

class MyPage extends StatelessWidget {
  const MyPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return LoginScreen();
  }
}

// 희히 신난다!!!