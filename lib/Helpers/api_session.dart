import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qbittorent_remote/Models/info_list.dart';
import 'package:qbittorent_remote/Models/torrent_info.dart';

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
          print('Response not recieved: ${e}');
          return false;
        }

  }

  Future<InfoList> getTorrentInfo() async {
    InfoList? torrentInfo = null;
    print(headers);
    try {
      var url = Uri.parse(_baseurl!+'/api/v2/torrents/info');
      var response = await client.get(url, headers: headers);
      var jsonString = response.body;
      var jsonMap = json.decode(jsonString);
      //Iterable l = json.decode(response.body);
      //torrentInfo = List<TorrentInfo>.from(l.map((model)=> TorrentInfo.fromJson(model)));
      torrentInfo  = InfoList.fromJson(jsonMap);
      print('Response status for get info: ${response.statusCode}');
      print('Response body for get info: ${response.body}');
    }catch(e) {
      print(e);
      throw Exception(e);
    }
    return torrentInfo;
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