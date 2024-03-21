import 'package:flutter/material.dart';
import 'package:mmd/screens/camera.dart';
import '../style/custom_color.dart';
import '../style/size_form.dart';

class BottomScreen extends StatefulWidget {
  const BottomScreen({Key? key}) : super(key: key);

  @override
  State<BottomScreen> createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 20,
            spreadRadius: 0,
            color: Colors.black.withOpacity(0.1)
          )
        ]
      ),
      child: BottomAppBar(
        surfaceTintColor: Colors.white,
        shape: CircularNotchedRectangle(),
        color: Colors.white,
        child: Container(
            width: mediaWidth(context, 1),
            height: 60.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Image.asset('assets/images/bottom_home.png',
                    width: mediaWidth(context, 0.1),),
                  onPressed: () {},
                ),
                Spacer(),
                // 원하는 위치에 IconButton 추가
                IconButton(
                  icon: Image.asset('assets/images/bottom_profile.png',
                    width: mediaWidth(context, 0.1),),
                  onPressed: () {},
                ),
                Spacer(flex: 6),
                IconButton(
                  icon: Image.asset('assets/images/bottom_note.png',
                    width: mediaWidth(context, 0.1),),
                  onPressed: () {},
                ),
                Spacer(),
                IconButton(
                  icon: Image.asset('assets/images/bottom_dict.png',
                  width: mediaWidth(context, 0.1),),
                  onPressed: () {},
                ),
              ],
            ),
          ),
      ),
    );
  }
}

class BottomFAB extends StatelessWidget {
  const BottomFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: mediaWidth(context, 0.22222),
      height: mediaHeight(context, 0.1),
      child: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: CustomColor().AccentColor(),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyCamera()));
          // Add your onPressed code here!
        },
        child: Image.asset(
          'assets/images/bottom_camera.png',
          color: Colors.white,
        ),
        elevation: 0,
      ),
    );
  }
}