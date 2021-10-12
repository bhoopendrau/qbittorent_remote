import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:qbittorent_remote/Models/extraInfo.dart';
import 'package:qbittorent_remote/Models/info_list.dart';

class Session {
  late String _baseurl,infoListUrl,extrainfoUrl;
  var client = http.Client();
  Map<String, String> headers = {};

  Session(String url) {
    _baseurl = url;
    infoListUrl = _baseurl+'/api/v2/torrents/info';
    extrainfoUrl = _baseurl+'/api/v2/torrents/properties';
  }


  Future login(String username, String password) async {
    final request = {
      "username": username,
      "password": password
    };
        try {
          var url = Uri.parse(_baseurl+'/api/v2/auth/login');
          var response = await client.post(url, body: request);

          return updateCookie(response);
        }catch(e) {
          return false;
        }

  }

  Future<InfoList> torrentList() async {
    InfoList? torrentList = null;
    try {
      var url = Uri.parse(_baseurl+'/api/v2/torrents/info');
      var response = await client.get(url, headers: headers);
      var jsonString = response.body;
      var jsonMap = json.decode(jsonString);
      torrentList  = InfoList.fromJson(jsonMap);
    }catch(e) {
      print(e);
      throw Exception(e);
    }
    return torrentList;
  }

  Stream<InfoList> getTorrentList(Duration refreshTime) async* {
    while (true) {
      await Future.delayed(refreshTime);
      try {
        yield await torrentList();
      } catch (e) {
        print(e);
      }
    }
  }


  Future<ExtraInfo> torrentInfo(String? hash) async {
    ExtraInfo? extraInfo = null;
    print(headers);
    if (hash==null){hash ="";}
    final request = {"hash": hash};

    try {
      var url = Uri.parse(_baseurl+'/api/v2/torrents/properties');
      var response = await client.post(url, body:request, headers: headers);
      var jsonString = response.body;
      var jsonMap = json.decode(jsonString);
      extraInfo  = ExtraInfo.fromJson(jsonMap);

    }catch(e) {
      print(e);
      throw Exception(e);
    }
    return extraInfo;
  }

  Stream<ExtraInfo> getTorrentInfo(Duration refreshTime, String? hash) async* {
    while (true) {
      await Future.delayed(refreshTime);
      try {
        yield await torrentInfo(hash);
      } catch (e) {
        print(e);
      }
    }
  }

  Future post(String endpoint, Map data) async {
    try {
      var url = Uri.parse(_baseurl+endpoint);
      var response = await client.post(url, body: data,headers: headers);

    }catch(e) {
      throw Exception(e);

    }
  }

  bool updateCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      //print(rawCookie);
      headers['cookie'] =
      (index == -1) ? rawCookie : rawCookie.substring(0, index);
      return true;
    } else {
      return false;
    }
  }

  Future uploadFile({file:PlatformFile}) async {
  var url = Uri.parse(_baseurl+'/api/v2/torrents/add');
    var request = http.MultipartRequest('POST', url);
    request.headers.addAll(headers);
    request.files.add(new http.MultipartFile.fromBytes("torrent", file.bytes, filename: file.name));
    var res = await request.send();
    return res.reasonPhrase;
  }
}