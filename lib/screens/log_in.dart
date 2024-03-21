import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart'; // Potentially for date formatting (if needed)
import 'main_screen.dart';
import '../style/custom_color.dart';

// Remove mysql_client (not required for secure storage)
import '../back_module/sqlclient.dart';
import '../style/size_form.dart';
import 'join.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final storage = const FlutterSecureStorage(); // Secure storage instance

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그인'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _idController,
              decoration: InputDecoration(labelText: '아이디'),
            ),
            TextField(
              controller: _pwController,
              obscureText: true,
              decoration: InputDecoration(labelText: '비밀번호'),
            ),
            ElevatedButton(
              onPressed: () async {
                String? result = await sqlget().GetUserByIdPw(
                    id: _idController.text, pw: _pwController.text);
                if (result == null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('서버 오류'),
                  ));
                  return;
                } else if (result == "id") {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('아이디가 틀렸습니다.'),
                  ));
                  return;
                } else if (result == "pw") {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('비밀번호가 틀렸습니다.'),
                  ));
                  return;
                }

                // Login successful - store credentials securely, show success message, and navigate
                await storage.write(key: 'loggedIn', value: 'true');
                await storage.write(
                    key: 'userId', value: result); // Store user ID securely
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text('로그인 성공!'),
                  duration: Duration(seconds: 3),
                ));
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                );
              },
              child: Text('로그인'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JoinPage()),
                );
              },
              child: Text('회원가입'),
            ),
          ],
        ),
      ),
    );
  }
}
