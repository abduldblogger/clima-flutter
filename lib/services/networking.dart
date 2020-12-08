import 'dart:convert';

import 'package:clima/utilities/constants.dart';
import 'package:http/http.dart' as http;

class Networking {
  String _url;

  Networking(this._url);

  Future getData() async {
    http.Response response = await http.get(_url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(kDataFetchFailMsg);
    }
  }
}
