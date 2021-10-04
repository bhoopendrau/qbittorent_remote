import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qbittorent_remote/Helpers/api_session.dart';
import 'package:qbittorent_remote/Models/custom_colors.dart';
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
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              child: ElevatedButton(
                onPressed: (){},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(CustomColors.PrimaryAssentColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                              child: Text(
                                  '${Conversions.progressToPercentage(info.progress)}',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                   color: Colors.black
                                ),
                              )
                          ),
                          Expanded(
                              child: Text('${info.name}',
                                maxLines: 2,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.black
                                ),
                              ),
                              flex: 9,
                          ),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${Conversions.formatBytes(info.downloaded, 2)}'
                                    +' of ('+'${Conversions.formatBytes(info.size, 2)}'+')',
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.black
                                ),
                              ),
                              flex: 5,
                            ),
                            Expanded(
                              child: Text(
                                "${Conversions.intToSpeed(info.upspeed)}",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.black
                                ),
                              ),
                              flex: 2,
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "${Conversions.intToSpeed(info.dlspeed)}",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.black
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
         ),
          // SizedBox(
          //   height: 5,
          // )
        ]
      )
    );
  }
}