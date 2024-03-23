import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mmd/screens/login_screen.dart';
import 'quiz/quiz_screen.dart';
import 'package:mmd/state_bar/appbar_screen.dart';
import 'package:mmd/state_bar/bottom_screen.dart';
import 'package:mmd/state_bar/menu.dart';
import '../style/size_form.dart';
import 'camera.dart';
import '../style/contents.dart';
import '../back_module/sqlclient.dart';
import '../screens/dict_list_screen2.dart';
import 'dict_screen.dart';
import '../contents/image_down.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? user_no;

  // 4. 세션 토큰 검사
  void Checktoken() async {
    String? no = await Token().Gettoken();

    if (no == null) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      setState(() {
        user_no = no;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Checktoken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar_screen(isMainScreen: true),
      drawer: MenuScreen(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TitleBanner(TitleText: '메인 화면'),
            SizedBox(
              width: mediaWidth(context, 1),
              height: mediaHeight(context, 0.0375),
            ),
            MainContents(
              ImagePath: 'assets/images/main_camera.png',
              title_text: '사물 촬영',
              subtitle_text: '이미지를 촬영하여 검색 해봅시다.',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyCamera()));
              },
            ),
            SizedBox(
              width: mediaWidth(context, 1),
              height: mediaHeight(context, 0.025),
            ),
            MainContents(
              ImagePath: 'assets/images/main_dict.png',
              title_text: '나만의 사전',
              subtitle_text: '저장한 단어들을 볼수 있어요.',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Dict_List2()));
              },
            ),
            SizedBox(
              width: mediaWidth(context, 1),
              height: mediaHeight(context, 0.025),
            ),
            MainContents(
              ImagePath: 'assets/images/quiz.png',
              title_text: '퀴즈 퀴즈',
              subtitle_text: '정답을 맞춰보세요!',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Quiz_Screen(),
                        settings:
                            RouteSettings(arguments: {'user_no': user_no})));
              },
            ),
            SizedBox(
              width: mediaWidth(context, 1),
              height: mediaHeight(context, 0.0375),
            ),
            Container(
              width: mediaWidth(context, 0.888889),
              height: mediaHeight(context, 0.05),
              alignment: Alignment.topLeft,
              child: Text(
                '나만의 사전',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder(
              future: sqlget().GetMydicList(user_no: user_no),
              builder: (context,
                  AsyncSnapshot<List<Map<String, String?>>?> snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                List<Map<String, String?>> postList = snapshot.data ?? [];
                postList = postList.reversed.toList(); // 리스트를 거꾸로 정렬합니다.
                postList =
                    postList.take(6).toList(); // 마지막에 추가된 10개의 아이템만 선택합니다.
                if (postList.isNotEmpty) {
                  return CarouselSlider(
                    options: CarouselOptions(

                      height: 260,
                      viewportFraction: 0.5,
                      aspectRatio: 16 / 9,
                      scrollDirection: Axis.horizontal,
                      autoPlay: true,
                      enableInfiniteScroll: true,
                      initialPage: 0,
                      autoPlayInterval: Duration(seconds: 5),
                    ),
                    items: postList.map((item) {
                      return _buildListItem(item);
                    }).toList(),
                  );
                } else {
                  return Container(
                    height: 100,
                    child: Center(
                      child: Text('현재 이미지가 존재하지 않습니다.'),
                    ),
                  );
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
            MainContents(
              ImagePath: 'assets/images/main_note.png',
              title_text: '잠시동안 로그아웃',
              subtitle_text: '로그아웃 합니다 (임시 로그아웃용)',
              onTap: () async {
                // 로그아웃 기능
                Token().Deltoken();
                await GoogleSignIn().signOut();
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
            SizedBox(
              height: mediaHeight(context, 0.1),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomFAB(),
      bottomNavigationBar: BottomScreen(),
    );
  }

  Widget _buildListItem(Map<String, String?> item) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          width: 140,
          height: 230,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 2,
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(0, 0))
            ],
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Dict_Screen(),
                      settings: RouteSettings(arguments: {
                        'user_no': user_no,
                        'word_kor': item['word_kor'],
                        'mean': item['mean'],
                        'mydic_no': item['mydic_no'],
                        'word_eng': item['word_eng']
                      })));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                    width: 100,
                    height: 100,
                    alignment: Alignment.center,
                    child: SnapShotImage(
                        mydic_no: item['mydic_no'], user_no: user_no)),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    item['word_kor'] ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    item['word_eng'] ?? "",
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Container(
                    width: 40,
                    height: 20,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 0,
                          blurRadius: 2,
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        minimumSize: Size(40, 20),
                        // 최소 크기 지정
                        padding: EdgeInsets.zero,
                        backgroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero),
                      ),
                      onPressed: () {},
                      child: Text(
                        'X',
                        style: TextStyle(
                          color: Colors.red[300],
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
