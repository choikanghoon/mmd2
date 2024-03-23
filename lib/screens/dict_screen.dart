import 'package:flutter/material.dart';
import '../contents/image_down.dart';
import '../state_bar/bottom_screen.dart';
import '../state_bar/appbar_screen.dart';
import '../style/contents.dart';
import '../style/custom_color.dart';
import '../style/button.dart';

class Dict_Screen extends StatefulWidget {
  const Dict_Screen({Key? key}) : super(key: key);

  @override
  State<Dict_Screen> createState() => _Dict_ScreenState();
}

class _Dict_ScreenState extends State<Dict_Screen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String? user_no = args['user_no'];
    String? word_kor = args['word_kor'];
    String? mean = args['mean'];
    String? mydic_no = args['mydic_no'];
    String? word_eng = args['word_eng'];
    return Scaffold(
      appBar: Appbar_screen(isMainScreen: false),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TitleBanner(TitleText: '나만의 사전'),
            SizedBox(height: 30),
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 3,
                    spreadRadius: 0,
                    color: Colors.black.withOpacity(0.2),
                  ),
                ],
                color: Colors.white,
              ),
              child: SnapShotImage(mydic_no: mydic_no, user_no: user_no),
            ),
            SizedBox(height: 20),
            Container(
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 180,
                    height: 60,
                    child: Text("${word_kor!} / ${word_eng!}"),
                    decoration: BoxDecoration(
                      color: CustomColor().SubColor(),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  ElevatedButton(
                    style: Style.mainButtonStyle3.copyWith(
                      fixedSize: MaterialStateProperty.all(Size(100, 60)),
                    ),
                    onPressed: () {},
                    child: Text('발음듣기'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              child: Container(
                width: 300,
                color: Colors.grey[300],
                child: Column(
                  children: [
                    Text(
                      mean!,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: BottomFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomScreen(),
    );
  }
}
