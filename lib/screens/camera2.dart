import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mmd/state_bar/appbar_screen.dart';
import 'package:mmd/state_bar/bottom_screen.dart';
import 'package:mmd/style/button.dart';
import '../back_module/s3client.dart';
import '../style/contents.dart';
import 'login_screen.dart';
import '../back_module/sqlclient.dart';
import '../back_module/modelapi.dart';
import '../contents/image_down.dart';

class MyCamera2 extends StatefulWidget {

  @override
  State<MyCamera2> createState() => _MyCamera2State();
}

class _MyCamera2State extends State<MyCamera2> {
  String? user_no;
  String? eng=null;
  String? label=null;
  String? dic_no=null;
  String? mydic_no;

  // 4. 세션 토큰 검사
  void Checktoken() async {
    String? no = await Token().Gettoken();

    if (no == null) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      setState(() {
        user_no = no;
      });}
  }

  void GetData() async {
    // mydic_no 넘버 도출
    String? future_mydic_no = await sqlget().GetNewMyDicNo();
    setState(() {
      mydic_no = future_mydic_no;
    });

    // EC2모델 접근
    String? future_eng = await GetLabel(user_no: user_no, mydic_no: mydic_no)
        .get_label();
    setState(() {
      eng = future_eng!.trim();
    });

    // eng통해 sql 접근
    String? future_label = await sqlget().GetWordKorByEng(eng: this.eng);
    String? future_dic_no = await sqlget().GetNoByEng(eng: this.eng);

    setState(() {
      label = future_label;
      dic_no = future_dic_no;
    });
    }

  @override
  void initState() {
    super.initState();
    Checktoken();
    GetData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: Appbar_screen(
        isMainScreen: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TitleBanner(TitleText: "사물 촬영"),
          SizedBox(
            height: 30,
          ),
          Container(
            width: 300,
            height: 300,
            child: SnapShotImage(
              user_no: user_no,
              mydic_no: mydic_no,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: label!=null ? Text(label!):Text("분석 중"),
            alignment: Alignment.center,
            width: 300,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(20)),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Awss3Send(user_no: user_no, mydic_no: mydic_no)
                        .remove(); // s3 사진 지우기
                    Navigator.pop(context);
                  },
                  child: Text('취소하기'),
                  style: Style.mainButtonStyle2.copyWith(
                    fixedSize: MaterialStateProperty.all(
                      Size(130, 60),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    String? dic_no = await sqlget().GetNoByEng(eng: eng);
                    print(dic_no);
                    bool TF = await sqlget().SaveImageInfo(
                        user_no: user_no, dic_no: dic_no);

                    if (TF) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('저장되었습니다.'),
                      ));
                      // 홈화면으로
                      Navigator.popUntil(context, (route) => route.isFirst);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('다시 시도해주시기 바랍니다.'),
                      ));
                    }
                  },
                  child: Text('저장하기'),
                  style: Style.mainButtonStyle3.copyWith(
                    fixedSize: MaterialStateProperty.all(
                      Size(130, 60),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomScreen(),
      floatingActionButton: BottomFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}