import 'package:flutter/material.dart';
import 'package:mmd/style/contents.dart';
import '../style/size_form.dart';
import '../style/custom_color.dart';

class Dict_List extends StatefulWidget {
  const Dict_List({Key? key});

  @override
  State<Dict_List> createState() => _Dict_ListState();
}

class _Dict_ListState extends State<Dict_List> {
  final PostList = [
    {'image': 'assets/images/dog.jpg', 'kor': '개', 'eng': 'dog'},
    {'image': 'assets/images/dog.jpg', 'kor': '고양이', 'eng': 'dog'},
    {'image': 'assets/images/dog.jpg', 'kor': '호랑이', 'eng': 'tiger'},
    {'image': 'assets/images/dog.jpg', 'kor': '원숭이', 'eng': 'monkey'},
    {'image': 'assets/images/dog.jpg', 'kor': '원숭이', 'eng': 'monkey'},
    {'image': 'assets/images/dog.jpg', 'kor': '원숭이', 'eng': 'monkey'},
    {'image': 'assets/images/dog.jpg', 'kor': '원숭이', 'eng': 'monkey'},
    {'image': 'assets/images/dog.jpg', 'kor': '원숭이', 'eng': 'monkey'},
    {'image': 'assets/images/dog.jpg', 'kor': '원숭이', 'eng': 'monkey'},
    {'image': 'assets/images/dog.jpg', 'kor': '원숭이', 'eng': 'monkey'},
    {'image': 'assets/images/dog.jpg', 'kor': '원숭이', 'eng': 'monkey'},
    {'image': 'assets/images/dog.jpg', 'kor': '원숭이', 'eng': 'monkey'},
    {'image': 'assets/images/dog.jpg', 'kor': '원숭이', 'eng': 'monkey'},
    {'image': 'assets/images/dog.jpg', 'kor': '원숭이', 'eng': 'monkey'},
    {'image': 'assets/images/dog.jpg', 'kor': '원숭이', 'eng': 'monkey'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: (PostList.length / 2).ceil(),
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildListItem(PostList[index * 2]),
                    SizedBox(width: 20), // 각 아이템 사이의 간격 조절
                    if (index * 2 + 1 < PostList.length)
                      _buildListItem(PostList[index * 2 + 1]),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildListItem(Map<String, dynamic> item) {
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
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: InkWell(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  item['image']!,
                  width: mediaWidth(context, 0.277778),
                  height: mediaHeight(context, 0.125),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: mediaHeight(context, 0.0125)),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  item['kor']!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: mediaWidth(context, 0.03),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: mediaHeight(context, 0.0125)),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  item['eng']!,
                  style: TextStyle(
                    fontSize: mediaWidth(context, 0.03),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: mediaHeight(context, 0.025)),
            ],
          ),
        ),
      );
  }
}
