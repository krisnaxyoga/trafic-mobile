import 'dart:convert';

import 'package:mobile_traffic/config/session.dart';
import 'package:mobile_traffic/data/model/workshop.dart';
import 'package:mobile_traffic/config/app_request.dart';

class SourceWorkshop {
  static Future<List<Workshop>> getWorkshop() async {
    final token = await Session.getToken();
    if (token == null) return <Workshop>[];

    String url = 'http://192.168.131.248:8000/api/levels';
    final responseBody = await AppRequest.gets(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print(responseBody);
    if (responseBody?['success'] == true) {
      final List<dynamic> list = responseBody?['data'];
      return list.map<Workshop>((json) => Workshop.fromJson(json)).toList();
    } else {
      return <Workshop>[];
    }
  }

  static Future<bool> createWorkshop({
    required String name,
    required String ownerName,
    required String address,
    required String email,
    required String workshopName,
    required String primaryNumber,
    required String secondaryNumber,
    required String whatsappNumber,
  }) async {
    final token = await Session.getToken();
    if (token == null) return false;

    String url = 'http://192.168.131.248:8000/api/workshop';
    final Map<String, dynamic> requestBody = {
      'name': name,
      'owner_name': ownerName,
      'address': address,
      'email': email,
      'workshop_name': workshopName,
      'primary_number': primaryNumber,
      'secondary_number': secondaryNumber,
      'whatsapp_number': whatsappNumber,
      'password': 'password',
    };

    final response = await AppRequest.post(
      url,
      requestBody,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response?['success'] == true) {
      return true;
    } else {
      return false;
    }
  }
}
