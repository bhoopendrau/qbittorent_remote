import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qbittorent_remote/Helpers/api_session.dart';
import 'package:qbittorent_remote/Helpers/shared_pref_helper.dart';
import 'package:qbittorent_remote/Models/server.dart';
import 'package:qbittorent_remote/Pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Loader extends StatefulWidget {
  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {

  @override
  void initState() {
    super.initState();
    nextPage();
  }

  Future<void> nextPage() async {
    await Future.delayed(const Duration(seconds: 2), () async {
      SharedPref pref = SharedPref();
      pref.sharedPrefInit();
      String? list = await pref.getString("serverList");
      if (list == null){
        Navigator.pushReplacementNamed(context, '/addserver', arguments: {
          'from' : 'loader'
        });
      } else {
        var api_session = Session("http://152.70.53.181:8080");
        await api_session.login("bhuppi", "18120120229").then((value) async {
          if (value == true) {
            Navigator.pushReplacement(
                context, new MaterialPageRoute(
                builder: (__) => new Home(api_session:api_session)));
          } else {
            print("login failed");
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Loading",
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlueAccent
                  ),
                ),
              ),
              SpinKitWave(
              color: Colors.lightBlueAccent,
              size: 50.0
            ),]
          ),
        ),
      )
    );
  }
}