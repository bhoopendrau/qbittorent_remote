import 'package:flutter/material.dart';
import 'package:qbittorent_remote/Helpers/api_session.dart';
import 'package:qbittorent_remote/Models/torrent_info.dart';
import 'package:qbittorent_remote/Pages/info_tabs/files.dart';
import 'package:qbittorent_remote/Pages/info_tabs/info.dart';
import 'package:qbittorent_remote/Pages/info_tabs/peers.dart';
import 'package:qbittorent_remote/Pages/info_tabs/trackers.dart';


class Torrent_Details extends StatefulWidget {
  late Session api_session;
  late TorrentInfo info;

  Torrent_Details({required this.info, required this.api_session});

  @override
  _Torrent_DetailsState createState() => _Torrent_DetailsState();
}

class _Torrent_DetailsState extends State<Torrent_Details> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Torrent Details'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Info',),
              Tab(text: 'Files',),
              Tab(text: 'Trackers',),
              Tab(text: 'Peers',),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Info(info:widget.info,api_session:widget.api_session),
            Files(),
            Trackers(),
            Peers()
          ],
        ),
      ),
    );
  }
}