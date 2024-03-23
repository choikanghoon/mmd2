import 'package:flutter/material.dart';
import '../back_module/s3client.dart';
import 'dart:typed_data';

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
          return Image.memory(snapshot.data!, fit: BoxFit.cover,);
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