// To parse this JSON data, do
//
//     final extraInfo = extraInfoFromJson(jsonString);

import 'dart:convert';

ExtraInfo extraInfoFromJson(String str) => ExtraInfo.fromJson(json.decode(str));

String extraInfoToJson(ExtraInfo data) => json.encode(data.toJson());

class ExtraInfo {
  ExtraInfo({
    this.additionDate,
    this.comment,
    this.completionDate,
    this.createdBy,
    this.creationDate,
    this.dlLimit,
    this.dlSpeed,
    this.dlSpeedAvg,
    this.eta,
    this.lastSeen,
    this.nbConnections,
    this.nbConnectionsLimit,
    this.peers,
    this.peersTotal,
    this.pieceSize,
    this.piecesHave,
    this.piecesNum,
    this.reannounce,
    this.savePath,
    this.seedingTime,
    this.seeds,
    this.seedsTotal,
    this.shareRatio,
    this.timeElapsed,
    this.totalDownloaded,
    this.totalDownloadedSession,
    this.totalSize,
    this.totalUploaded,
    this.totalUploadedSession,
    this.totalWasted,
    this.upLimit,
    this.upSpeed,
    this.upSpeedAvg,
  });

  int? additionDate;
  String? comment;
  int? completionDate;
  String? createdBy;
  int? creationDate;
  int? dlLimit;
  int? dlSpeed;
  int? dlSpeedAvg;
  int? eta;
  int? lastSeen;
  int? nbConnections;
  int? nbConnectionsLimit;
  int? peers;
  int? peersTotal;
  int? pieceSize;
  int? piecesHave;
  int? piecesNum;
  int? reannounce;
  String? savePath;
  int? seedingTime;
  int? seeds;
  int? seedsTotal;
  double? shareRatio;
  int? timeElapsed;
  int? totalDownloaded;
  int? totalDownloadedSession;
  int? totalSize;
  int? totalUploaded;
  int? totalUploadedSession;
  int? totalWasted;
  int? upLimit;
  int? upSpeed;
  int? upSpeedAvg;

  factory ExtraInfo.fromJson(Map<String, dynamic> json) => ExtraInfo(
    additionDate: json["addition_date"],
    comment: json["comment"],
    completionDate: json["completion_date"],
    createdBy: json["created_by"],
    creationDate: json["creation_date"],
    dlLimit: json["dl_limit"],
    dlSpeed: json["dl_speed"],
    dlSpeedAvg: json["dl_speed_avg"],
    eta: json["eta"],
    lastSeen: json["last_seen"],
    nbConnections: json["nb_connections"],
    nbConnectionsLimit: json["nb_connections_limit"],
    peers: json["peers"],
    peersTotal: json["peers_total"],
    pieceSize: json["piece_size"],
    piecesHave: json["pieces_have"],
    piecesNum: json["pieces_num"],
    reannounce: json["reannounce"],
    savePath: json["save_path"],
    seedingTime: json["seeding_time"],
    seeds: json["seeds"],
    seedsTotal: json["seeds_total"],
    shareRatio: json["share_ratio"].toDouble(),
    timeElapsed: json["time_elapsed"],
    totalDownloaded: json["total_downloaded"],
    totalDownloadedSession: json["total_downloaded_session"],
    totalSize: json["total_size"],
    totalUploaded: json["total_uploaded"],
    totalUploadedSession: json["total_uploaded_session"],
    totalWasted: json["total_wasted"],
    upLimit: json["up_limit"],
    upSpeed: json["up_speed"],
    upSpeedAvg: json["up_speed_avg"],
  );

  Map<String, dynamic> toJson() => {
    "addition_date": additionDate,
    "comment": comment,
    "completion_date": completionDate,
    "created_by": createdBy,
    "creation_date": creationDate,
    "dl_limit": dlLimit,
    "dl_speed": dlSpeed,
    "dl_speed_avg": dlSpeedAvg,
    "eta": eta,
    "last_seen": lastSeen,
    "nb_connections": nbConnections,
    "nb_connections_limit": nbConnectionsLimit,
    "peers": peers,
    "peers_total": peersTotal,
    "piece_size": pieceSize,
    "pieces_have": piecesHave,
    "pieces_num": piecesNum,
    "reannounce": reannounce,
    "save_path": savePath,
    "seeding_time": seedingTime,
    "seeds": seeds,
    "seeds_total": seedsTotal,
    "share_ratio": shareRatio,
    "time_elapsed": timeElapsed,
    "total_downloaded": totalDownloaded,
    "total_downloaded_session": totalDownloadedSession,
    "total_size": totalSize,
    "total_uploaded": totalUploaded,
    "total_uploaded_session": totalUploadedSession,
    "total_wasted": totalWasted,
    "up_limit": upLimit,
    "up_speed": upSpeed,
    "up_speed_avg": upSpeedAvg,
  };
}
