import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mmd/back_module/sqlclient.dart';
import '../state_bar/appbar_screen.dart';
import '../style/size_form.dart';
import '../back_module/s3client.dart';
import '../style/button.dart';
import '../style/contents.dart';
import 'package:google_fonts/google_fonts.dart';
import '../state_bar/bottom_screen.dart';
import 'camera2.dart';

class MyCamera extends StatefulWidget {
  const MyCamera({super.key});

  @override
  State<MyCamera> createState() => _MyCameraState();
}

class _MyCameraState extends State<MyCamera> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _getImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source, maxWidth: 300, maxHeight: 300);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar_screen(isMainScreen: false),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TitleBanner(TitleText: '사물 촬영'),
          SizedBox(height: mediaHeight(context, 0.0375), width: double.infinity),
          _buildPhotoArea(),
          SizedBox(height: mediaHeight(context, 0.025)),
          _buildButton(),
          SizedBox(height: mediaHeight(context, 0.025)),
          _buildSendButton()
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomFAB(),
      bottomNavigationBar: BottomScreen(),
    );

  }

  Widget _buildPhotoArea() {
    return _image != null
        ? Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      width: mediaWidth(context, 0.83333),
      height: mediaHeight(context, 0.375),
      child: Image.file(File(_image!.path)),
    )
        : Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 0),
              blurRadius: 2,
              spreadRadius: 0,
              color: Colors.black.withOpacity(0.2)),
        ],
      ),
      width: mediaWidth(context, 0.83333),
      height: mediaHeight(context, 0.375),
      child: Image.asset(
        'assets/images/camera.png',
        width: mediaWidth(context, 0.38889),
        height: mediaHeight(context, 0.175),
        fit: BoxFit.none,
      ),
    );
  }

  Widget _buildButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            _getImage(ImageSource.camera);
          },
          child: Text("카메라"),
          style: Style.mainButtonStyle1.copyWith(
              fixedSize: MaterialStateProperty.all(Size(
                  mediaWidth(context, 0.36111), mediaHeight(context, 0.075)))),
        ),
        SizedBox(width: mediaWidth(context, 0.11111)),
        ElevatedButton(
          onPressed: () {
            _getImage(ImageSource.gallery);
          },
          style: Style.mainButtonStyle2.copyWith(
            fixedSize: MaterialStateProperty.all(Size(mediaWidth(context, 0.36111), mediaHeight(context, 0.075))),
          ),
          child: Text("갤러리"),
        ),
      ],
    );
  }

  Widget _buildSendButton() {


    return ElevatedButton(

      onPressed: () async {
        // 수정필요
        String? user_no = await Token().Gettoken();
        String? mydic_no = await sqlget().GetNewMyDicNo();
        Awss3Send(user_no: user_no,mydic_no: mydic_no).upload(_image!.path);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyCamera2(),
              settings: RouteSettings(arguments: {'user_no':user_no, 'mydic_no':mydic_no})),
        );
      },
      child: Text('사용하기'),
      style: Style.mainButtonStyle3.copyWith(fixedSize: MaterialStateProperty.all(Size(mediaWidth(context, 0.83333), mediaHeight(context, 0.075))),
      ),
    );
  }
}