import 'package:flutter/material.dart';
import '../style/contents.dart';
import '../style/custom_color.dart';
import '../back_module/sqlclient.dart';

class JoinScreen extends StatefulWidget {
  const JoinScreen({super.key});

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _conpwController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool IdCheck = false;
  String? _confirmPasswordError;

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return '비밀번호를 입력해주세요.';
    }
    // 여기에 추가적인 비밀번호 유효성 검사 로직을 추가할 수 있습니다.
    // 예를 들어, 최소 길이, 특수문자 포함 등의 규칙을 검사할 수 있습니다.
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TitleBanner(TitleText: '회원가입 화면'),
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: 360,
                    height: 30,
                    color: Colors.white,
                    child: Text(
                      'ID',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: TextField(
                            controller: _idController,
                            style: TextStyle(fontSize: 18),
                            decoration: InputDecoration(
                                hintText: 'Enter your ID',
                                hintStyle: TextStyle(
                                    color: Colors.grey.withOpacity(0.8)),
                                // 힌트 텍스트 색상 및 투명도 조절
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: Colors.grey) // 선 색상 지정
                                    ),
                                contentPadding: EdgeInsets.all(3)),
                          ),
                        ),
                      ),
                      SizedBox(width: 10), // 텍스트 필드와 버튼 사이 간격 조절
                      ElevatedButton(
                        onPressed: () async {
                          // 버튼 클릭 시 동작 추가
                          String? check = await sqlget()
                              .GetUserByIdPw(id: _idController.text);
                          if (check == 'pw') {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('장난하니?.'),
                            ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('사용 가능 합니다.'),
                            ));
                            IdCheck = true;
                          }
                        },
                        child: Text(
                          '중복 확인',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              CustomColor().SubColor()),
                          minimumSize: MaterialStateProperty.all(Size(80, 50)),
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(10)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  pw_Tile(
                      first_Text: 'Password',
                      hint_Text: 'Enter your Password',
                      controller: _pwController,
                      obscure: true,
                      validator: validatePassword),
                  pw_Tile(
                    first_Text: 'Confirm Password',
                    hint_Text: 'Enter your Password',
                    controller: _conpwController,
                    obscure: true,
                    validator: (value) {
                      if (value != _pwController.text) {
                        return '비밀번호가 일치하지 않습니다.';
                      }
                      return null;
                    },
                    errorText: _confirmPasswordError,
                  ),
                  Text_Tile(
                    first_Text: 'Email',
                    hint_Text: 'Enter your Email',
                    Controll: _emailController,
                    Obsure: false,
                  ),
                  Text_Tile(
                    first_Text: 'Name',
                    hint_Text: 'Enter your Name',
                    Controll: _nameController,
                    Obsure: false,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      bool result = await sqlget().UserJoin(
                          id: _idController.text,
                          pw: _pwController.text,
                          // email: _emailController.text,
                          name: _nameController.text);
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
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      '뒤로가기',
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    _conpwController.addListener(_checkConfirmPassword);
  }

  @override
  void dispose() {
    _conpwController.removeListener(_checkConfirmPassword);
    super.dispose();
  }

  // 비밀번호 확인 필드 값 변경 시 호출되는 함수
  void _checkConfirmPassword() {
    setState(() {
      if (_conpwController.text != _pwController.text) {
        _confirmPasswordError = '비밀번호가 일치하지 않습니다.';
      } else {
        _confirmPasswordError = null;
      }
    });
  }
}
