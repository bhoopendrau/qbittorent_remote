// To parse this JSON data, do
//
//     final torrentInfo = torrentInfoFromJson(jsonString);

import 'dart:convert';

List<TorrentInfo> torrentInfoFromJson(String str) => List<TorrentInfo>.from(json.decode(str).map((x) => TorrentInfo.fromJson(x)));

String torrentInfoToJson(List<TorrentInfo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TorrentInfo {
  TorrentInfo({
    this.addedOn,
    this.amountLeft,
    this.autoTmm,
    this.availability,
    this.category,
    this.completed,
    this.completionOn,
    this.contentPath,
    this.dlLimit,
    this.dlspeed,
    this.downloaded,
    this.downloadedSession,
    this.eta,
    this.fLPiecePrio,
    this.forceStart,
    this.hash,
    this.lastActivity,
    this.magnetUri,
    this.maxRatio,
    this.maxSeedingTime,
    this.name,
    this.numComplete,
    this.numIncomplete,
    this.numLeechs,
    this.numSeeds,
    this.priority,
    this.progress,
    this.ratio,
    this.ratioLimit,
    this.savePath,
    this.seedingTime,
    this.seedingTimeLimit,
    this.seenComplete,
    this.seqDl,
    this.size,
    this.state,
    this.superSeeding,
    this.tags,
    this.timeActive,
    this.totalSize,
    this.tracker,
    this.trackersCount,
    this.upLimit,
    this.uploaded,
    this.uploadedSession,
    this.upspeed,
  });

  int? addedOn;
  int? amountLeft;
  bool? autoTmm;
  double? availability;
  String? category;
  int? completed;
  int? completionOn;
  String? contentPath;
  int? dlLimit;
  int? dlspeed;
  int? downloaded;
  int? downloadedSession;
  int? eta;
  bool? fLPiecePrio;
  bool? forceStart;
  String? hash;
  int? lastActivity;
  String? magnetUri;
  int? maxRatio;
  int? maxSeedingTime;
  String? name;
  int? numComplete;
  int? numIncomplete;
  int? numLeechs;
  int? numSeeds;
  int? priority;
  double? progress;
  double? ratio;
  int? ratioLimit;
  String? savePath;
  int? seedingTime;
  int? seedingTimeLimit;
  int? seenComplete;
  bool? seqDl;
  int? size;
  String? state;
  bool? superSeeding;
  String? tags;
  int? timeActive;
  int? totalSize;
  String? tracker;
  int? trackersCount;
  int? upLimit;
  int? uploaded;
  int? uploadedSession;
  int? upspeed;

  factory TorrentInfo.fromJson(Map<String, dynamic> json) => TorrentInfo(
    addedOn: json["added_on"],
    amountLeft: json["amount_left"],
    autoTmm: json["auto_tmm"],
    availability: json["availability"].toDouble(),
    category: json["category"],
    completed: json["completed"],
    completionOn: json["completion_on"],
    contentPath: json["content_path"],
    dlLimit: json["dl_limit"],
    dlspeed: json["dlspeed"],
    downloaded: json["downloaded"],
    downloadedSession: json["downloaded_session"],
    eta: json["eta"],
    fLPiecePrio: json["f_l_piece_prio"],
    forceStart: json["force_start"],
    hash: json["hash"],
    lastActivity: json["last_activity"],
    magnetUri: json["magnet_uri"],
    maxRatio: json["max_ratio"],
    maxSeedingTime: json["max_seeding_time"],
    name: json["name"],
    numComplete: json["num_complete"],
    numIncomplete: json["num_incomplete"],
    numLeechs: json["num_leechs"],
    numSeeds: json["num_seeds"],
    priority: json["priority"],
    progress: json["progress"].toDouble(),
    ratio: json["ratio"].toDouble(),
    ratioLimit: json["ratio_limit"],
    savePath: json["save_path"],
    seedingTime: json["seeding_time"],
    seedingTimeLimit: json["seeding_time_limit"],
    seenComplete: json["seen_complete"],
    seqDl: json["seq_dl"],
    size: json["size"],
    state: json["state"],
    superSeeding: json["super_seeding"],
    tags: json["tags"],
    timeActive: json["time_active"],
    totalSize: json["total_size"],
    tracker: json["tracker"],
    trackersCount: json["trackers_count"],
    upLimit: json["up_limit"],
    uploaded: json["uploaded"],
    uploadedSession: json["uploaded_session"],
    upspeed: json["upspeed"],
  );

  Map<String, dynamic> toJson() => {
    "added_on": addedOn,
    "amount_left": amountLeft,
    "auto_tmm": autoTmm,
    "availability": availability,
    "category": category,
    "completed": completed,
    "completion_on": completionOn,
    "content_path": contentPath,
    "dl_limit": dlLimit,
    "dlspeed": dlspeed,
    "downloaded": downloaded,
    "downloaded_session": downloadedSession,
    "eta": eta,
    "f_l_piece_prio": fLPiecePrio,
    "force_start": forceStart,
    "hash": hash,
    "last_activity": lastActivity,
    "magnet_uri": magnetUri,
    "max_ratio": maxRatio,
    "max_seeding_time": maxSeedingTime,
    "name": name,
    "num_complete": numComplete,
    "num_incomplete": numIncomplete,
    "num_leechs": numLeechs,
    "num_seeds": numSeeds,
    "priority": priority,
    "progress": progress,
    "ratio": ratio,
    "ratio_limit": ratioLimit,
    "save_path": savePath,
    "seeding_time": seedingTime,
    "seeding_time_limit": seedingTimeLimit,
    "seen_complete": seenComplete,
    "seq_dl": seqDl,
    "size": size,
    "state": state,
    "super_seeding": superSeeding,
    "tags": tags,
    "time_active": timeActive,
    "total_size": totalSize,
    "tracker": tracker,
    "trackers_count": trackersCount,
    "up_limit": upLimit,
    "uploaded": uploaded,
    "uploaded_session": uploadedSession,
    "upspeed": upspeed,
  };

  static List<TorrentInfo> decode(String servers) =>
      (json.decode(servers) as List<dynamic>)
          .map<TorrentInfo>((item) => TorrentInfo.fromJson(item))
          .toList();
}
