import 'package:http/http.dart' as http;
import 'dart:convert';
import '../back_module/label.dart';
import '../back_module/s3client.dart';

class GetLabel {
  // 생성자로 받을 url
  String? user_no;
  String? mydic_no;

  // 생성자
  GetLabel({required this.user_no, required this.mydic_no});

  // label.dart 참조
  List<String> text_label = Label.labellist;

  // api주소
  String api_url = 'http://13.209.64.182/';

  // map화
  Map<String, dynamic> toMap() => {'path': Awss3Send(user_no:this.user_no, mydic_no: this.mydic_no).PathMaker(), 'labels': text_label.join(',')};

  // json 송신 후 label return 받기
  Future<String?> get_label() async {
    Uri real_url = Uri.parse(api_url);
    http.Response response = await http.post(real_url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(toMap()));

    // 리턴 받은 값 출력
    if (response.statusCode == 200) {
      String json = jsonDecode(response.body);
      List<String> list = json.split(',');
      List<String> list1 = list[0].split(':');
      // List<String> list2 = list[1].split(':');

      String? data = list1[1];
      return data;
    } else {
      String? data = null;
      return data;
    }
  }
}
