import 'package:flutter/material.dart';
import '../contents/image_down.dart';
import '../screens/dict_screen.dart';
import '../state_bar/appbar_screen.dart';
import '../style/contents.dart';
import '../style/size_form.dart';
import '../state_bar/bottom_screen.dart';
import '../back_module/sqlclient.dart';
import '../screens/login_screen.dart';

class Dict_List2 extends StatefulWidget {
  const Dict_List2({super.key});

  @override
  State<Dict_List2> createState() => _Dict_List2State();
}

class _Dict_List2State extends State<Dict_List2> {
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
      appBar: Appbar_screen(isMainScreen: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TitleBanner(TitleText: '나만의 사전'),
            SizedBox(height: 30,),
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
                final List<Map<String, String?>> PostList = snapshot.data!;
                if (PostList.isNotEmpty) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: (PostList.length / 2).ceil(),
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildListItem(PostList[index * 2]),
                          SizedBox(width: 20), // 각 아이템 사이의 간격 조절
                          if (index * 2 + 1 < PostList.length)
                            _buildListItem(PostList[index * 2 + 1]),
                        ],
                      );
                    },
                  );
                } else {
                  return Container(
                    height: mediaHeight(context, 0.7),
                    child: Center(
                      child: Text('현재 이미지가 존재하지 않습니다.'),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: BottomFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomScreen(),
    );
  }

  Widget _buildListItem(Map<String, String?> item) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(mediaHeight(context, 0.025)),
          width: mediaWidth(context, 0.388889),
          height: mediaHeight(context, 0.2875),
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
                  height: mediaHeight(context, 0.0125),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    item['word_kor'] ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: mediaWidth(context, 0.03),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: mediaHeight(context, 0.0125),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    item['word_eng'] ?? "",
                    style: TextStyle(
                        fontSize: mediaWidth(context, 0.03),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: mediaHeight(context, 0.025),
                ),
                Expanded(
                  child: Container(
                    width: mediaWidth(context, 0.1111),
                    height: mediaHeight(context, 0.025),
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
                        minimumSize: Size.zero,
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
                            fontSize: mediaWidth(context, 0.03)),
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
