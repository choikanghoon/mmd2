import 'package:flutter/material.dart';
import '../style/size_form.dart';
import '../style/custom_color.dart';

class Appbar_screen extends StatelessWidget implements PreferredSizeWidget {
  final bool isMainScreen; // main_screen.dart에서만 메뉴 버튼을 사용할지 여부

  const Appbar_screen({Key? key, required this.isMainScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.white,
      shadowColor: Colors.black.withOpacity(0.2),
      backgroundColor: Colors.white,
      title: Text('My Memory Dictionary',
        style: TextStyle(
            color: CustomColor().TextColor(),
        ),
      ),
      centerTitle: true,
      leading: isMainScreen ? _buildMenuButton(context) : _buildBackButton(context), // 삼항 연산자 boolean 조건 ? 무엇True : 무엇False
      actions: <Widget>[
        // IconButton(
        //   icon: Image.asset(
        //     'assets/images/search.png',
        //     width: 24,
        //     height: 24,
        //   ),
        //   color: Colors.black,
        //   onPressed: () {
        //     print('Search button is clicked');
        //   },
        // ),
        IconButton(
          icon: Image.asset(
            'assets/images/bottom_profile.png',
            width: mediaWidth(context, 0.1),
            height: mediaHeight(context, 0.05),
          ),
          onPressed: () {
            print('Profile button is clicked');
          },
        ),
      ],
      // main_screen.dart에서는 메뉴 버튼, 나머지에서는 뒤로가기 버튼 사용
    );
  }

  // 메뉴 버튼 생성
  Widget _buildMenuButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.menu,
        size: mediaWidth(context, 0.08),
        color: CustomColor().TextColor(),
      ),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    );
  }

  // 뒤로가기 버튼 생성
  Widget _buildBackButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        size: mediaWidth(context, 0.08),
        color: CustomColor().TextColor(),
      ),
      onPressed: () {
        Navigator.pop(context); // 이전 화면으로 이동
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
