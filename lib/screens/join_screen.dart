import 'package:flutter/material.dart';
import '../style/contents.dart';
import '../style/custom_color.dart';
import '../back_module/sqlclient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

class JoinScreen extends StatefulWidget {
  const JoinScreen({super.key});

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _conpwController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool IdCheck = false; // 아이디 중복확인
  String? _confirmPasswordError;
  int? _gender = 0; // 기본값 남성

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return '비밀번호를 입력해주세요.';
    }
    // 여기에 추가적인 비밀번호 유효성 검사 로직을 추가할 수 있습니다.
    // 예를 들어, 최소 길이, 특수문자 포함 등의 규칙을 검사할 수 있습니다.
    return null;
  }

  // 회원가입 가능여부 판단
  bool CheckJoin() {
    // 1. 비밀번호 공백인지 + 동일한지
    bool PwCheck = (_pwController.text == _conpwController.text) &&
        (_pwController.text != "");
    return IdCheck && PwCheck;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TitleBanner(TitleText: '회원가입'),
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
                          // 빈칸 입력 시
                          if (_idController.text == "") {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('아이디를 입력해주시기 바랍니다.'),
                            ));
                            IdCheck = false; // IDCheck 중복 확인이 안 됐거나, 중복이거나
                            return; // 밑에까지 안 가고 여기서 코드를 끝낸다.
                          }

                          // 버튼 클릭 시 동작 추가
                          String? check = await sqlget()
                              .GetUserByIdPw(id: _idController.text);
                          if (check == 'pw') {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('중복된 아이디가 있습니다.'),
                            ));
                            IdCheck = false;
                          } else if (check == 'id') {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('사용 가능 합니다.'),
                            ));
                            IdCheck = true;
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('서버 오류, 다시 시도해주시기 바랍니다.'),
                            ));
                            IdCheck = false;
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
                      // value = _conpwController
                      if (value != _pwController.text) {
                        return '비밀번호가 일치하지 않습니다.';
                      }
                      return null; // 위의 조건 통과
                    },
                    errorText: _confirmPasswordError,
                  ),
                  Container(
                    width: double.infinity,
                    height: 30,
                    color: Colors.white,
                    child: Text(
                      'Birth',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: TextField(
                            controller: _birthController,
                            style: TextStyle(fontSize: 18),
                            decoration: InputDecoration(
                                hintText: 'Enter your birth',
                                hintStyle: TextStyle(
                                    color: Colors.grey.withOpacity(0.8)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                contentPadding: EdgeInsets.all(3)),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          showCupertinoModalPopup(
                              context: context,
                              builder: (context) {
                                final initDate = DateTime.now();
                                return Container(
                                  height: 300,
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Done'),
                                      ),
                                      Expanded(
                                        child: CupertinoDatePicker(
                                          maximumYear: DateTime.now().year,
                                          maximumDate: DateTime.now(),
                                          initialDateTime: initDate,
                                          mode: CupertinoDatePickerMode.date,
                                          onDateTimeChanged: (DateTime date) {
                                            final selectedDate = DateTime(
                                                date.year, date.month, date.day);
                                            setState(() {
                                              _birthController.text = selectedDate
                                                  .toIso8601String()
                                                  .split('T')[0];
                                            });
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }
                          );
                        },
                        child: Text(
                          '생년월일',
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
                  Text_Tile(
                    first_Text: 'Name',
                    hint_Text: 'Enter your Name',
                    Controll: _nameController,
                    Obsure: false,
                  ),
                  SizedBox(
                    height: 10,
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
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 18,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          '뒤로가기',
                          style: TextStyle(
                            color: Colors.black, // 텍스트 색상을 원하는 색상으로 변경
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            CustomColor().SubColor(),
                          ),
                          minimumSize: MaterialStateProperty.all<Size>(
                            Size(150, 50),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          // if (_idController.text = "") {
                          //
                          // }
                          if (IdCheck != true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('아이디 중복확인을 해주세요.')));
                            return;
                          }

                          bool Join_Ok = CheckJoin();

                          if (Join_Ok) {
                            bool result = await sqlget().UserJoin(
                                id: _idController.text,
                                pw: _pwController.text,
                                gender: _gender,
                                birth: _birthController.text,
                                name: _nameController.text);
                            if (result) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('회원가입 성공!'),
                              ));
                              Navigator.of(context).pop();
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('서버 연결 오류!'),
                              ));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('모든 항목들을 작성해주세요.'),
                            ));
                          }
                        },
                        child: Text(
                          '회원가입',
                          style: TextStyle(
                            color: Colors.black, // 텍스트 색상을 원하는 색상으로 변경
                            fontWeight: FontWeight.bold, // 텍스트 두께를 원하는 두께로 변경
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            CustomColor().AccentColor(),
                          ),
                          minimumSize: MaterialStateProperty.all<Size>(
                            Size(150, 50),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
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
  } // listener 기능 - 위의 코드가 실행될 때, 동시에 이 함수를 같이 실행시켜라

  @override
  void dispose() {
    _conpwController.removeListener(_checkConfirmPassword);
    super.dispose(); // join_screen이 끝날 때, 이 함수도 꺼라
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
