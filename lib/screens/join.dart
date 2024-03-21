import 'package:flutter/material.dart';
import '../back_module/sqlclient.dart';



class JoinPage extends StatefulWidget {
  const JoinPage({Key? key}) : super(key: key);

  @override
  _JoinPageState createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  int? _gender = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'),
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
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: '이름'),
            ),
            TextField(
              controller: _birthController,
              decoration: InputDecoration(labelText: '생년월일 (YYYY-MM-DD)'),
            ),
            RadioListTile(
              title: Text('남성'),
              value: 0,
              groupValue: _gender,
              onChanged: (value) {
                setState(() {
                  _gender = value as int?;
                });
              },
            ),
            RadioListTile(
              title: Text('여성'),
              value: 1,
              groupValue: _gender,
              onChanged: (value) {
                setState(() {
                  _gender = value as int?;
                });
              },
            ),
            ElevatedButton(
              onPressed: () async {
                bool result = await sqlget().UserJoin(
                    id: _idController.text,
                    pw: _pwController.text,
                    name: _nameController.text,
                    birth: _birthController.text,
                    gender: _gender);
                if (result) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('회원가입 성공!'),
                  ));
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('회원가입 실패!'),
                  ));
                }
              },
              child: Text('회원가입'),
            ),
          ],
        ),
      ),
    );
  }
}

