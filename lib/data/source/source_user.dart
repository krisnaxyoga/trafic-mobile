import 'package:d_info/d_info.dart';
import 'package:mobile_traffic/config/api.dart';
import 'package:mobile_traffic/config/app_request.dart';
import 'package:mobile_traffic/config/session.dart';
import 'package:mobile_traffic/data/model/user.dart';

class SourceUser {
  static Future<bool> login(String email, String password) async {
    String url = 'https://be-traffic.tenryubito.com/api/login';
    Map? responseBody = await AppRequest.post(url, {
      'email': email,
      'password': password,
    });

    if (responseBody == null) return false;

    if (responseBody['success']) {
      print(responseBody);
      var mapUser = responseBody['user'];
      if (mapUser != null) {
        Session.saveUser(User.fromJson(mapUser), token: responseBody['token']);
      } else {
        DInfo.toastError('Gagal Login');
      }
    }

    return responseBody['success'];
  }

  static Future<bool> register(
      String name, String email, String password) async {
    String url = 'https://be-traffic.tenryubito.com/api/register';
    Map? responseBody = await AppRequest.post(url, {
      'name': name,
      'email': email,
      'password': password,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    });
    print(responseBody);
    if (responseBody == null) return false;

    if (responseBody['success']) {
      DInfo.notifSuccess('success', 'success registrasi');
    } else {
      if (responseBody['message'] == 'email') {
        DInfo.toastError('Email sudah terdaftar');
      } else {
        DInfo.toastError('Gagal Register');
      }
    }

    return responseBody['success'];
  }

  static Future<List<User>> getUser() async {
    final token = await Session.getToken();
    if (token == null) return <User>[];

    String url = 'https://be-traffic.tenryubito.com/api/users';
    final responseBody = await AppRequest.gets(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print(responseBody);
    if (responseBody?['success'] == true) {
      final List<dynamic> list = responseBody?['data'];
      return list.map<User>((json) => User.fromJson(json)).toList();
    } else {
      return <User>[];
    }
  }
}
