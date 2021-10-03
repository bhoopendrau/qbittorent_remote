import 'dart:convert';
import 'package:http/http.dart' as http;

class Session {
  String? _baseurl;
  var client = http.Client();
  Map<String, String> headers = {};

  Session(String url) {
    _baseurl = url;

  }


  Future login(String username, String password) async {
    final request = {
      "username": username,
      "password": password
    };
        try {
          var url = Uri.parse(_baseurl!+'/api/v2/auth/login');
          var response = await client.post(url, body: request);
          print('Response status: ${response.statusCode}');
          print('Response body: ${response.body}');
          return updateCookie(response);
        }catch(e) {
          return false;
        }

  }

  Future get(String endpoint) async {
    try {
      var url = Uri.parse(_baseurl!+endpoint);
      var response = await client.get(url, headers: headers);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }catch(e) {
      throw Exception(e);

    }
  }

  Future post(String endpoint, Map data) async {
    try {
      var url = Uri.parse(_baseurl!+endpoint);
      var response = await client.post(url, body: data,headers: headers);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }catch(e) {
      throw Exception(e);

    }
  }

  bool updateCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      print(rawCookie);
      headers['cookie'] =
      (index == -1) ? rawCookie : rawCookie.substring(0, index);
      return true;
    } else {
      return false;
    }
  }
}