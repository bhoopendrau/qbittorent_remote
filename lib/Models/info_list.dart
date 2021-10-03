import 'package:qbittorent_remote/Models/torrent_info.dart';

class InfoList {
  final List<TorrentInfo> infos;

  InfoList({
     required this.infos,
  });

  factory InfoList.fromJson(List<dynamic> parsedJson) {
    List<TorrentInfo> infos = <TorrentInfo>[];
    infos = parsedJson.map((i)=>TorrentInfo.fromJson(i)).toList();
    print("info list "+infos.length.toString());
    return new InfoList(
      infos: infos,
    );
  }
}