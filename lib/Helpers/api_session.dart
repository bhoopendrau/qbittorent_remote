import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qbittorent_remote/Models/extraInfo.dart';
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

  Future<InfoList> getTorrentList() async {
    InfoList? torrentList = null;
    print(headers);
    try {
      var url = Uri.parse(_baseurl!+'/api/v2/torrents/info');
      var response = await client.get(url, headers: headers);
      var jsonString = response.body;
      var jsonMap = json.decode(jsonString);
      torrentList  = InfoList.fromJson(jsonMap);
      print('Response status for get info List: ${response.statusCode}');
      print('Response body for get info List: ${response.body}');
    }catch(e) {
      print(e);
      throw Exception(e);
    }
    return torrentList;
  }


  Future<ExtraInfo> getTorrentInfo(String? hash) async {
    ExtraInfo? extraInfo = null;
    print(headers);
    if (hash==null){
     hash ="";
    }
    final request = {
      "hash": hash
    };

    try {
      var url = Uri.parse(_baseurl!+'/api/v2/torrents/properties');
      print(hash);
      var response = await client.post(url, body:request, headers: headers);
      var jsonString = response.body;
      var jsonMap = json.decode(jsonString);
      extraInfo  = ExtraInfo.fromJson(jsonMap);
      print('Response status for get info: ${response.statusCode}');
      print('Response body for get info: ${response.body}');
    }catch(e) {
      print(e);
      throw Exception(e);
    }
    return extraInfo;
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