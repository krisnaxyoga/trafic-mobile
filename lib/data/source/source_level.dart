import 'package:mobile_traffic/config/app_request.dart';
import 'package:mobile_traffic/config/session.dart';
import 'package:mobile_traffic/data/model/level.dart';

class SourceLevel {
  static Future<List<Level>> getLevel() async {
    final token = await Session.getToken();
    if (token == null) return <Level>[];

    String url = 'http://192.168.181.248:8000/api/level';
    final responseBody = await AppRequest.gets(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print(responseBody);
    if (responseBody?['success'] == true) {
      final List<dynamic> list = responseBody?['data'];
      return list.map<Level>((json) => Level.fromJson(json)).toList();
    } else {
      return <Level>[];
    }
  }
}