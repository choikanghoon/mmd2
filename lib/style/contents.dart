import 'package:flutter/material.dart';
import 'size_form.dart';
import 'custom_color.dart';

class TitleBanner extends StatelessWidget {
  final String TitleText;

  TitleBanner({required this.TitleText});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: mediaWidth(context, 1),
      height: mediaHeight(context, 0.1),
      color: CustomColor().SubColor(),
      child: Text(
        TitleText,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: mediaWidth(context, 0.06),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class MainContents extends StatelessWidget {
  final VoidCallback onTap;
  final String ImagePath;
  final String title_text;
  final String subtitle_text;

  const MainContents({
    required this.onTap,
    required this.ImagePath,
    required this.title_text,
    required this.subtitle_text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: mediaWidth(context, 0.88889),
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 2,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: mediaWidth(context, 0.2222),
              child: Center(
                child: Image.asset(
                  ImagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: mediaWidth(context, 0.6111),
              height: mediaHeight(context, 0.125),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(title_text),
                subtitle: Text(
                  subtitle_text,
                  style: TextStyle(fontSize: mediaWidth(context, 0.025)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Dict_Card extends StatefulWidget {
  final VoidCallback onTap;
  final String ImagePath;
  final String kor;
  final String eng;
  final VoidCallback onPressed;

  const Dict_Card({
    required this.onTap,
    required this.ImagePath,
    required this.kor,
    required this.eng,
    required this.onPressed,
  });

  @override
  State<Dict_Card> createState() => _Dict_CardState();
}

class _Dict_CardState extends State<Dict_Card> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
        onTap: widget.onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                widget.ImagePath,
                width: mediaWidth(context, 0.277778),
                height: mediaHeight(context, 0.125),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: mediaHeight(context, 0.0125),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                widget.kor,
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
                widget.eng,
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
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.white,
                    elevation: 0,
                    shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                  onPressed: widget.onPressed,
                  child: Container(
                    width: mediaWidth(context, 0.1111),
                    height: mediaHeight(context, 0.025),
                    alignment: Alignment.center,
                    child: Text(
                      'X',
                      style: TextStyle(
                          color: Colors.red[300],
                          fontSize: mediaWidth(context, 0.03)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Text_Tile extends StatefulWidget {
  final String first_Text;
  final String hint_Text;
  final dynamic Controll;
  final bool Obsure;

  const Text_Tile({
    required this.first_Text,
    required this.hint_Text,
    required this.Controll,
    required this.Obsure,
  });

  @override
  State<Text_Tile> createState() => _Text_TileState();
}

class _Text_TileState extends State<Text_Tile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 360,
          height: 30,
          color: Colors.white,
          // padding: EdgeInsets.only(left: 10), // 패딩 추가
          child: Text(
            widget.first_Text,
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          //상하좌우로 띄워주기
          padding: const EdgeInsets.only(top: 5, bottom: 20),
          child: TextField(
            controller: widget.Controll,
            obscureText: widget.Obsure,
            style: TextStyle(fontSize: 18),
            decoration: InputDecoration(
                hintText: widget.hint_Text,
                hintStyle: TextStyle(color: Colors.grey.withOpacity(0.8)),
                // 힌트 텍스트 색상 및 투명도 조절
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.grey), // 선 색상 지정
                ),
                contentPadding: EdgeInsets.all(3)),
          ),
        ),
      ],
    );
  }
}


class pw_Tile extends StatefulWidget {
  final String first_Text;
  final String hint_Text;
  final TextEditingController controller;
  final bool obscure;
  final String? Function(String?) validator;
  final String? errorText;

  const pw_Tile({
    Key? key,
    required this.first_Text,
    required this.hint_Text,
    required this.controller,
    required this.obscure,
    required this.validator,
    this.errorText,
  }) : super(key: key);

  @override
  State<pw_Tile> createState() => _pw_TileState();
}

class _pw_TileState extends State<pw_Tile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 360,
          height: 30,
          color: Colors.white,
          child: Text(
            widget.first_Text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 20),
          child: TextFormField(
            validator: widget.validator,
            controller: widget.controller,
            obscureText: widget.obscure,
            style: TextStyle(fontSize: 18),
            decoration: InputDecoration(
              hintText: widget.hint_Text,
              errorText: widget.errorText,
              hintStyle: TextStyle(color: Colors.grey.withOpacity(0.8)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.grey),
              ),
              contentPadding: EdgeInsets.all(3),
            ),
          ),
        ),
      ],
    );
  }
}
