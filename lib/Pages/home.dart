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

  late Future<InfoList> _torrentInfoList;
  @override
  void initState() {
    _torrentInfoList = widget.api_session.getTorrentList();
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 1, 0, 1),
                        child: SizedBox(
                          height: 70,
                            width: 70,
                            child: _progressBar(info.progress)
                        )
                      ),
                      Flexible(
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
                      ),
                    ]),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            child: Row(
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
                            ),
                            flex: 3,
                          ),
                          Expanded(
                            flex: 3,
                            child: Row(
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
                            ),
                          )
                        ],
                      ),
                    ),
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
    return InkWell(
      onTap: (){},
      child: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                value: progress,
                valueColor: AlwaysStoppedAnimation(Colors.green),
                backgroundColor: Colors.grey,
                strokeWidth: 6,
              ),
            ),
          ),
          Center(
            child: Icon(
              Icons.pause_circle_outline,
              size: 30,
              color: Colors.green
            ),
          )
        ],
      ),
    );
  }
}