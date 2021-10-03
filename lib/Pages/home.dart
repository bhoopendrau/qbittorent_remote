import 'package:flutter/material.dart';
import 'dart:convert';

class home extends StatefulWidget {
  var api_session;


  home({this.api_session});


  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home')
      ),
      body: Text("Hello world"),
    );
  }
}