import 'package:flutter/material.dart';
import 'package:qbittorent_remote/Pages/add_server.dart';
import 'package:qbittorent_remote/Pages/home.dart';
import 'package:qbittorent_remote/Pages/loader.dart';
import 'package:qbittorent_remote/Pages/torrent_details.dart';

void main() => runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => loader(),
      '/home': (context) => home(),
      '/location': (context) => torrent_details(),
      '/addserver': (context) => add_server()
    }
));
