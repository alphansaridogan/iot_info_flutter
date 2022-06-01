import 'dart:convert';

import 'iot_info_model.dart';
import 'package:http/http.dart' as http ;

class IotService {
  final String IotUrl = 'https://cdn2021.sepetta.com/alp/test.txt';



  Future<IotInfoModel?> fetchInfo() async {
    var res = await http.get(Uri.parse(IotUrl));
    if(res.statusCode == 200 ) {
      var jsonBody = IotInfoModel.fromJson(jsonDecode(res.body));
      return jsonBody;
    } else {
      print('Bağlantıda bir hata oldu => ${res.statusCode}');
    }


  }

}

