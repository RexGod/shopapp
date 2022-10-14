import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/http_Exeption.dart';

// ignore: camel_case_types
class Auth with ChangeNotifier {
  String? _token;
  String? _userId;
  DateTime? _expireDate;

  bool get isAuth {
    // ignore: unnecessary_null_comparison
    return token != null;
  }

  String? get token {
    if (_token != null &&
        _expireDate != null &&
        _expireDate!.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  Future<void> _uthenticate(
      String email, String password, String userSegment) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$userSegment?key=AIzaSyDoRbtIZy-JJgTzrhgmNKJFsRMTi4EPeb4');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpExeption(responseData['error']['message'].toString());
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expireDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signUp(String email, String password) async {
    return _uthenticate(email, password, 'signUp');
  }

  Future<void> logIn(String email, String password) async {
    return _uthenticate(email, password, 'signInWithPassword');
  }
}
