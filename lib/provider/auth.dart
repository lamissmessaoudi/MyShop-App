import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> _authnticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyBUrfyd2s-NhQyrwuzSY239Qn16f460mOg';
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
    print(json.decode(response.body));
  }

  Future<void> singup(String email, String password) async {
    return _authnticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authnticate(email, password, 'signInWithPassword');
  }
}
