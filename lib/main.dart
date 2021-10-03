import 'package:flutter/material.dart';
import 'package:qbittorent_remote/Pages/add_server.dart';
import 'package:qbittorent_remote/Pages/home.dart';
import 'package:qbittorent_remote/Pages/loader.dart';
import 'package:qbittorent_remote/Pages/torrent_details.dart';

void main() => runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Loader(),
      '/location': (context) => Torrent_Details(),
      '/addserver': (context) => Add_Server()
    }
));
