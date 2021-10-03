import 'dart:convert';

class Server {
  late String? ip,port,user_name,password, cookies;
  Server({this.ip,this.port,this.user_name,this.password, this.cookies}){}

  factory Server.fromJson(Map<String, dynamic> jsonData) {
    return Server(
      ip: jsonData['ip'],
      port: jsonData['port'],
      user_name: jsonData['user_name'],
      password: jsonData['password'],
      cookies: jsonData['cookies'],
    );
  }

  static Map<String, dynamic> toMap(Server server) => {
    'ip': server.ip,
    'port': server.port,
    'user_name': server.user_name,
    'password': server.password,
    'cookies': server.cookies,
  };

  static String encode(List<Server> servers) => json.encode(
    servers
        .map<Map<String, dynamic>>((server) => Server.toMap(server))
        .toList(),
  );

  static List<Server> decode(String servers) =>
      (json.decode(servers) as List<dynamic>)
          .map<Server>((item) => Server.fromJson(item))
          .toList();
}
