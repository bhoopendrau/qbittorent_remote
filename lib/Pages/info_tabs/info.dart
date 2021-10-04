import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qbittorent_remote/Helpers/api_session.dart';
import 'package:qbittorent_remote/Models/extraInfo.dart';
import 'dart:convert';

import 'package:qbittorent_remote/Models/torrent_info.dart';


class Info extends StatefulWidget {
  late TorrentInfo info ;
  late Session api_session;

  Info({required this.info, required this.api_session}){}
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {

  late Future<ExtraInfo> _extraInfo;

  @override
  void initState() {
    _extraInfo = widget.api_session.getTorrentInfo(widget.info.hash);
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder<ExtraInfo>(
            future: _extraInfo,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data.toString());
                return infoListView(snapshot.data);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }

        ),
      ),
    );
  }

  Widget infoListView(ExtraInfo? info) {
    if (info != null) {
      return Column(
        children: [
          Text('Connections'),
          rowTemplate('Connection', '${info.nbConnections}(${info.nbConnectionsLimit} max)'),
          rowTemplate('Seeds', '${info.seeds}(${info.seedsTotal} total)'),
          rowTemplate('Peers', '${info.peers}(${info.peersTotal} total)'),
          rowTemplate('Time Active', '${info.timeElapsed}'),
          rowTemplate('Seeding Time', '${info.seedingTime}'),
          rowTemplate('Downloaded', '${info.totalDownloaded}(${info.totalDownloadedSession} this session)'),
          rowTemplate('Uploaded', '${info.totalUploaded}(${info.totalUploadedSession} max)'),
        ],
      );
    } else {
      return Text(
        'Error'
      );
    }
  }

  Widget rowTemplate (String property, String value) {
    return Row(
      children: [
        Expanded(
          flex: 3,
            child: Text(property)
        ),
        Expanded(
          flex: 5,
            child: Text(value)
        )
      ],
    );
  }
}