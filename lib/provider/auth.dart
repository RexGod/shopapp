import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: camel_case_types
class auth with ChangeNotifier {
  Future<void> _uthenticate(
      String email, String password, String userSegment) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$userSegment?key=AIzaSyDoRbtIZy-JJgTzrhgmNKJFsRMTi4EPeb4');
    final response = await http.post(url,
        body: json.encode(
            {'email': email, 'password': password, 'returnSecureToken': true}));
    print(json.decode(response.body));
  }

  Future<void> signUp(String email, String password) async {
    _uthenticate(email, password, 'signUp');
  }

  Future<void> logIn(String email, String password) async {
    _uthenticate(email, password, 'signInWithPassword');
  }
}
