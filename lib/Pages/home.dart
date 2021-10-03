import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qbittorent_remote/Helpers/api_session.dart';
import 'package:qbittorent_remote/Models/info_list.dart';
import 'dart:convert';

import 'package:qbittorent_remote/Models/torrent_info.dart';
import 'package:qbittorent_remote/Utils/conversions.dart';

class Home extends StatefulWidget {
  late Session api_session;


  Home({required this.api_session});


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late Future<InfoList> _torrentInfoList;
  @override
  void initState() {
    _torrentInfoList = widget.api_session.getTorrentInfo();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home')
      ),
      body: Container(
        child: FutureBuilder<InfoList>(
          future: _torrentInfoList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data.toString());
              return ListView.builder(
                itemCount: snapshot.data!.infos.length,
                  itemBuilder: (context, index) {
                  var torrentInfo = snapshot.data!.infos[index];
                    return TorrentStatus(torrentInfo);
              });
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

  Widget TorrentStatus(TorrentInfo info) {
    return Container(
      child: Column(
        children: [
          Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Expanded(
                      child: Text('${info.name}',
                        maxLines: 2,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis
                        ),
                      ),
                      flex: 9,
                  ),
                  Expanded(
                      child: Text(
                          "${Conversions.formatBytes(info.size!, 2)}",
                          textAlign: TextAlign.end,
                      ),
                      flex: 2,
                  ),
                ],
              )
          ),
          SizedBox(height: 10,)
        ],
      ),
      color: Colors.lightBlueAccent[400],
    );
  }
}