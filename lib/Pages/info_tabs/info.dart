import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qbittorent_remote/Helpers/api_session.dart';
import 'package:qbittorent_remote/Models/extraInfo.dart';
import 'dart:convert';

import 'package:qbittorent_remote/Models/torrent_info.dart';
import 'package:qbittorent_remote/Utils/conversions.dart';


class Info extends StatefulWidget {
  late TorrentInfo info ;
  late Session api_session;

  Info({required this.info, required this.api_session}){}
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {

  final StreamController<ExtraInfo> _streamController = StreamController();
  late final Timer _timer;


  Future getExtraInfo() async {
    final request = {
      "hash": widget.info.hash
    };
    var api = widget.api_session;
    var url = Uri.parse(api.extrainfoUrl);
    var response = await api.client.post(url, body:request, headers: api.headers);
    _streamController.add( ExtraInfo.fromJson(json.decode(response.body)));
  }

  @override
  void dispose() {
    _streamController.close();
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      getExtraInfo();
    });
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder<ExtraInfo>(
            stream: _streamController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
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
      return ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                'Connections',
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          rowTemplate('Connection', '${info.nbConnections} ( ${info.nbConnectionsLimit} max)'),
          rowTemplate('Seeds', '${info.seeds} ( ${info.seedsTotal} total)'),
          rowTemplate('Peers', '${info.peers} ( ${info.peersTotal} total)'),
          rowTemplate('Time Active', '${Conversions.secondToTime(info.timeElapsed)}'),
          rowTemplate('Seeding Time', '${Conversions.secondToTime(info.seedingTime)}'),
          rowTemplate('Downloaded', '${Conversions.formatBytes(info.totalDownloaded)} ( ${Conversions.formatBytes(info.totalDownloadedSession)} this session)'),
          rowTemplate('Uploaded', '${Conversions.formatBytes(info.totalUploaded)} ( ${Conversions.formatBytes(info.totalUploadedSession)} max)'),
          rowTemplate('Down Speed', '${Conversions.intToSpeed(info.dlSpeed)} ( ${Conversions.intToSpeed(info.dlSpeedAvg)} avg)'),
          rowTemplate('Up Speed', '${Conversions.intToSpeed(info.upSpeed)} ( ${Conversions.intToSpeed(info.upSpeedAvg)} avg)'),
          rowTemplate('Download Limit', '${Conversions.intToSpeed(info.dlLimit)}'),
          rowTemplate('Upload Limit', '${Conversions.intToSpeed(info.upLimit)}'),
          rowTemplate('Wasted', '${Conversions.formatBytes(info.totalWasted)}'),
          rowTemplate('Ratio', '${info.shareRatio!.toStringAsFixed(2)}'),
          rowTemplate('Reannounce in', '${Conversions.secondToTime(info.reannounce)}'),
          rowTemplate('Last seen complete', '${Conversions.timeStampToDate(info.lastSeen)}'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                'Torrent Information',
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          rowTemplate('Total Size', '${Conversions.formatBytes(info.totalSize)}'),
          rowTemplate('Pieces', '${info.piecesNum} ( have ${info.piecesHave} )'),
          rowTemplate('Added On', '${Conversions.timeStampToDate(info.additionDate)}'),
          rowTemplate('Completed on', '${Conversions.timeStampToDate(info.completionDate)}'),
          rowTemplate('Created on', '${Conversions.timeStampToDate(info.creationDate)}'),
          rowTemplate('Save Path', '${info.savePath}'),
         // rowTemplate('Category ', '${info.category}'),
          rowTemplate('Torrent hash', '${widget.info.hash}'),
        ],
      );
    } else {
      return Text(
        'Error'
      );
    }
  }

  Widget rowTemplate (String property, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
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
      ),
    );
  }
}