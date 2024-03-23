import 'package:flutter/material.dart';
import '../style/contents.dart';
import '../style/custom_color.dart';
import '../screens/Join_screen.dart';
import 'main_screen.dart';
import '../back_module/sqlclient.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum LoginPlatform {
  google,none
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  LoginPlatform loginPlatform = LoginPlatform.none;

  @override
  void initState() {
    super.initState();
    GetNumber();
  }

  void signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if(googleUser != null) {
      print('name = ${googleUser.displayName}');
      print('email = ${googleUser.email}');
      print('id = ${googleUser.id}');

      setState(() {
        loginPlatform = LoginPlatform.google;
      });

      // 사용자 유무
      // sql에서 email, pw(googleUser.id) 체크
      String? userNo = await sqlget().GetUserByIdPw(id: googleUser.email, pw: googleUser.id);
      // 없으면 회원가입 (DB에 사용자 저장)
      if(userNo == 'id' || userNo == 'pw') {
        // 회원가입
        String name = googleUser.displayName as String;
        bool joinResult = await sqlget().UserJoin(
            id: googleUser.email,
            pw: googleUser.id,
            name: name);
        if(joinResult) {
          String? newUserNo = await sqlget().GetUserByIdPw(id: googleUser.email, pw: googleUser.id);
          Token().Settoken(userNo);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MainScreen(),
                settings: RouteSettings(
                    arguments: {'user_no': newUserNo})),
          );
        }
      } else {
        // 로그인
        Token().Settoken(userNo);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MainScreen(),
              settings: RouteSettings(
                  arguments: {'user_no': userNo})),
        );
      }
    }
  }

  Future<void> GetNumber() async {
    String? user_no = await Token().Gettoken();
    print(user_no);
    if (user_no != null) {
      // 다음 화면 넘기기
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MainScreen(),
            settings: RouteSettings(
                arguments: {'user_no': user_no})),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TitleBanner(TitleText: '로그인 화면'),
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Text_Tile(
                    first_Text: 'ID',
                    hint_Text: 'Enter your ID',
                    Controll: _idController,
                    Obsure: false,
                  ),
                  Text_Tile(
                    first_Text: 'Password',
                    hint_Text: 'Enter Your password',
                    Controll: _pwController,
                    Obsure: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_idController.text=="" || _pwController.text=="") {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('아이디, 비밀번호를 입력해주시기 바랍니다.'),
                        ));
                        return;
                      }

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
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Text('로그인 성공!'),
                          duration: Duration(seconds: 3),
                        ));
                        // 로그인 세션 유지
                        Token().Settoken(result);
                        // 다음 화면 넘기기
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainScreen(),
                              settings: RouteSettings(
                                  arguments: {'user_no': result})),
                        );
                      }
                    },
                    child: Text(
                      '로그인 하기',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black), // 글자 크기를 조정
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            CustomColor().AccentColor()),
                        minimumSize: MaterialStateProperty.all<Size>(
                          Size(160, 50),
                        )),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  GestureDetector(
                    onTap: () {
                      // GestureDetector가 탭되었을 때 실행할 동작을 정의합니다.
                      print('MMD 회원가입 하기 click');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => JoinScreen()));
                    },
                    child: Container(
                      width: 330,
                      height: 50,
                      padding: EdgeInsets.all(14.0),
                      decoration: BoxDecoration(
                        color: CustomColor().AccentColor(),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Stack(
                        children: [
                          // Positioned를 사용하여 이미지를 왼쪽 끝에 배치합니다.
                          Positioned(
                            left: 0,
                            top: 0,
                            bottom: 0,
                            child: Image.asset('assets/images/M.png'),
                          ),
                          Center(
                            child: Text(
                              'MMD 회원가입 하기',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18, // 텍스트의 크기를 조절합니다.
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 360,
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      signInWithGoogle();
                    },
                    child: Container(
                      width: 330,
                      height: 50,
                      padding: EdgeInsets.all(14.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.black,
                          width: 0.2,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            bottom: 0,
                            child: Image.asset('assets/images/google.png'),
                          ),
                          Center(
                            child: Text(
                              '구글로 로그인하기',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
