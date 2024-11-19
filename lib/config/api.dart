import 'package:mobile_traffic/data/model/question.dart';

class Api {
  static const baseUrl = 'http://10.0.2.2:8000/api';
  static const level = '$baseUrl/level';
  static const user = '$baseUrl/users';
  static const login = '$baseUrl/login';
  static const logout = '$baseUrl/logout';
  static const register = '$baseUrl/register';
  static const question = '$baseUrl/question';
  static const answer = '$baseUrl/question-jawab';
}
