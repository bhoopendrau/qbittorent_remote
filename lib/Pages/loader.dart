import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
    await Future.delayed(const Duration(seconds: 2), (){
      Navigator.pushReplacementNamed(context, '/addserver', arguments: {
        'from' : 'loader'
      });
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