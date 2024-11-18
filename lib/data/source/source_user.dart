import 'package:d_info/d_info.dart';
import 'package:mobile_traffic/config/api.dart';
import 'package:mobile_traffic/config/app_request.dart';
import 'package:mobile_traffic/config/session.dart';
import 'package:mobile_traffic/data/model/user.dart';

class SourceUser {
  static Future<bool> login(String email, String password) async {
    String url = 'http://10.0.2.2:8000/api/login';
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

  static Future<bool> logout() async {
    String url = 'http://10.0.2.2:8000/api/logout';
    Map? responseBody = await AppRequest.gets(url, headers: {
      'Authorization': 'Bearer ${await Session.getToken()}',
    });

    if (responseBody == null) return false;

    Session.clearUser();
    return responseBody['success'];
  }

  static Future<bool> register(
      String name, String email, String password) async {
    String url = 'http://10.0.2.2:8000/api/register';
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

  static Future<User?> getUser() async {
    final token = await Session.getToken();
    if (token == null) return null;

    String url = 'http://10.0.2.2:8000/api/users';
    final responseBody = await AppRequest.gets(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    print(responseBody);

    // Pastikan `success` adalah true dan `data` adalah list
    if (responseBody?['success'] == true && responseBody?['data'] is List) {
      // Ambil elemen pertama dari data
      final List<dynamic> data = responseBody?['data'];
      if (data.isNotEmpty) {
        // Ubah elemen pertama menjadi objek User
        return User.fromJson(data[0]);
      }
    }

    return null;
  }
}
