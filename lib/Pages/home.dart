import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qbittorent_remote/Helpers/api_session.dart';
import 'package:qbittorent_remote/Models/custom_colors.dart';
import 'package:qbittorent_remote/Models/info_list.dart';
import 'package:qbittorent_remote/Models/torrent_info.dart';
import 'package:qbittorent_remote/Pages/torrent_details.dart';
import 'package:qbittorent_remote/Utils/conversions.dart';

class Home extends StatefulWidget {
  late Session api_session;


  Home({required this.api_session});


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final StreamController<InfoList> _streamController = StreamController();
  late final Timer _timer;

  @override
  void dispose() {
    _streamController.close();
    _timer.cancel();
    super.dispose();
  }

  Future getInfoList() async {

    var api = widget.api_session;
    var url = Uri.parse(api.infoListUrl);
    var response = await api.client.get(url, headers: api.headers);
    _streamController.add(InfoList.fromJson(json.decode(response.body)));
  }

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      getInfoList();
    });
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home')
      ),
      body: Container(
        child: StreamBuilder<InfoList>(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
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
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              child: ElevatedButton(
                onPressed: (){
                  Navigator.push(
                      context, new MaterialPageRoute(
                      builder: (__) => new Torrent_Details(info: info, api_session: widget.api_session,)));
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(CustomColors.PrimaryAssentColor),
                ),
                child: Row(
                  children: [
                    _progressBar(info.progress),
                    mainContent(info)
                  ],
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

  Widget _progressBar (double? progress) {
    return SizedBox(
      height: 70,
      width: 70,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 8, 4),
              child: SizedBox(
                height: 60,
                width: 60,
                child: CircularProgressIndicator(
                  value: progress,
                  valueColor: AlwaysStoppedAnimation(Colors.green),
                  backgroundColor: Colors.grey,
                  strokeWidth: 6,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 8, 4),
            child: Center(
              child: Icon(
                Icons.pause_circle_outline,
                size: 40,
                color: Colors.green
              ),
            ),
          )
        ],
      ),
    );
  }
  
  Widget mainContent(TorrentInfo info) {
    return Column(
      children: [
        first_row(info),
        second_row(info),
        third_row(info)
      ],
    );
  }

  Widget first_row(TorrentInfo info) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text('${info.name}',
          maxLines: 2,
          style: TextStyle(
              overflow: TextOverflow.ellipsis,
              color: Colors.black
          ),
        ),
      ),
    );
  }

  Widget second_row(TorrentInfo info) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Down : ${Conversions.formatBytes(info.downloaded)}',
            style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: Colors.black
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.download_rounded,
                  size: 20,
                  color: CustomColors.CustomGreen,
                ),
                Text(

                  "${Conversions.intToSpeed(info.dlspeed)}",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.black
                  ),
                ),
              ]
          )
        ],
      ),
    );
  }

  Widget third_row(TorrentInfo info) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 2, 0, 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Up : ${Conversions.formatBytes(info.uploaded)}',
            style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: Colors.black
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.upload_rounded,
                  size: 20,
                  color: Colors.orange,
                ),
                Text(
                  "${Conversions.intToSpeed(info.upspeed)}",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.black
                  ),
                ),
              ]
          )
        ],
      ),
    );
  }
}