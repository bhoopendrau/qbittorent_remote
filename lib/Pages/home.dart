import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

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
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.add_event,
        backgroundColor: Colors.blueAccent,
        overlayColor: Colors.grey,
        openCloseDial: isDialOpen,
        overlayOpacity: 0.5,
        spacing: 15,
        spaceBetweenChildren: 15,
        children: [
          SpeedDialChild(
              child: Icon(Icons.insert_drive_file_outlined),
              label: '.Torrent file',
              backgroundColor: Colors.blue[200],
              onTap: (){
                print('Torrent Tapped');
                isDialOpen = ValueNotifier(false);
              }
          ),
          SpeedDialChild(
              child: Icon(Icons.add_link),
              label: 'Mail',
              backgroundColor: Colors.blue[200],
              onTap: (){
                print('Link Tapped');
                isDialOpen = ValueNotifier(false);
              }
          )
        ],
      ),
      body: Container(
        child: StreamBuilder<InfoList>(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
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

          ElevatedButton(
                 onPressed: (){
                   Navigator.push(
                       context, new MaterialPageRoute(
                       builder: (__) => new Torrent_Details(info: info, api_session: widget.api_session,)));
                 },
            style: ButtonStyle(
                   backgroundColor: MaterialStateProperty.all(CustomColors.PrimaryAssentColor),
                 ),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     first_row(info),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         _progressBar(info.progress),
                         mainContent(info)
                       ],
                     ),
                   ],
                 ),
          )
        ]
      )
    );
  }

  Widget _progressBar (double? progress) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5, 5, 5),
      child: SizedBox(
        height: 70,
        width: 70,
        child: InkWell(
          onTap: (){},
          child: Stack(
            fit: StackFit.passthrough,
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
        ),
      ),
    );
  }
  
  Widget mainContent(TorrentInfo info) {
    return Column(
      children: [
        second_row(info),
        third_row(info)
      ],
    );
  }

  Widget first_row(TorrentInfo info) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text('${info.name}',
        maxLines: 2,
        textAlign: TextAlign.start,
        style: TextStyle(
            overflow: TextOverflow.ellipsis,
            color: Colors.black
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