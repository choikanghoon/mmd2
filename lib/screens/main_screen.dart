import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mmd/state_bar/appbar_screen.dart';
import 'package:mmd/state_bar/bottom_screen.dart';
import 'dict_list_screen.dart';
import '../style/size_form.dart';
import 'camera.dart';
import '../style/custom_color.dart';
import '../style/contents.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar_screen(isMainScreen: true),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyCamera()),
                );
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Dict_List()),
                );
              },
            ),
            SizedBox(
              width: mediaWidth(context, 1),
              height: mediaHeight(context, 0.025),
            ),
            MainContents(
              ImagePath: 'assets/images/main_note.png',
              title_text: '나만의 일기',
              subtitle_text: '오늘 배운단어들과 연관지어 일기를 써보아요',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyCamera()),
                );
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
            CarouselSlider(
              options: CarouselOptions(
                  height: mediaHeight(context, 0.2875),
                  viewportFraction: 0.5,
                  aspectRatio: 16/9,
                  scrollDirection: Axis.horizontal,
                  autoPlay: true,
                  enableInfiniteScroll: true,
                  initialPage: 0,
                  autoPlayInterval: Duration(
                    seconds: 5,
                  ),
              ),
              items: [
                Dict_Card(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyCamera()),
                    );
                  },
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyCamera()),
                    );
                  },
                  ImagePath: 'assets/images/camera.png',
                  kor: '강아지',
                  eng: 'Dog',
                ),
                Dict_Card(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyCamera()),
                    );
                  },
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyCamera()),
                    );
                  },
                  ImagePath: 'assets/images/main_dict.png',
                  kor: '어쩌구',
                  eng: '저쩌구',
                ),
                Dict_Card(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyCamera()),
                    );
                  },
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyCamera()),
                    );
                  },
                  ImagePath: 'assets/images/dog.jpg',
                  kor: '숭구리',
                  eng: '당당',
                ),
              ],
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
}
