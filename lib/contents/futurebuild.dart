import 'package:flutter/material.dart';
import '../back_module/s3client.dart';
import 'dart:typed_data';
import '../back_module/modelapi.dart';

class SnapShotImage extends StatefulWidget {
  final String? user_no;
  final String? mydic_no;

  const SnapShotImage({
    required this.mydic_no,
    required this.user_no,
  });

  @override
  State<SnapShotImage> createState() => _SnapShotState();
}

class _SnapShotState extends State<SnapShotImage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      // user_id / mydic_no
      future: Awss3Get(widget.user_no).loadImage(widget.mydic_no), // null 체크 추가
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Image.memory(snapshot.data!);
        } else {
          return SizedBox(
            width: 300,
            height: 300,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

class FutureText extends StatefulWidget {
  final String? user_no;
  final String? mydic_no;

  const FutureText({
    required this.mydic_no,
    required this.user_no,
  });

  @override
  State<FutureText> createState() => _FutureTextState();
}
class _FutureTextState extends State<FutureText> {


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: GetLabel(user_no:widget.user_no, mydic_no:widget.mydic_no).get_label(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data!, textAlign: TextAlign.center,);
          } else {
            return Text('분석 중');
          }
        },
    );
  }
}
