import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mmd/state_bar/appbar_screen.dart';
import 'package:mmd/state_bar/bottom_screen.dart';
import 'package:mmd/style/button.dart';
import '../back_module/s3client.dart';
import '../style/contents.dart';
import '../contents/futurebuild.dart';

class MyCamera2 extends StatefulWidget {

  @override
  State<MyCamera2> createState() => _MyCamera2State();
}

class _MyCamera2State extends State<MyCamera2> {
  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)?.settings.arguments as Map<String, String?>;
    final user_no = args['user_no'];
    final mydic_no = args['mydic_no'];

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
            child: FutureText(
              user_no: user_no,
              mydic_no: mydic_no,
            ),
            alignment: Alignment.center,
            width: 300,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.yellow, borderRadius: BorderRadius.circular(20)),
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
                    Awss3Send(user_no: user_no, mydic_no: mydic_no).remove(); // s3 사진 지우기
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
                    // bool TF = await sqlget().SaveImageInfo(user_no:user_no, dic_no: "");
                    // print(TF); // true, false
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