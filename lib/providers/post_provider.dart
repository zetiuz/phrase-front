import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:phrase/models/post.dart';
import 'package:phrase/services/api_url.dart';
import 'package:phrase/utilities/user_preferences.dart';

/*
enum AuthStatus {
  notLoggedIn,
  notRegistered,
  loggedIn,
  registered,
  authenticating,
  registering,
  loggedOut
}*/

class PostProvider extends ChangeNotifier {
  /*AuthStatus _loggedInStatus = AuthStatus.notLoggedIn;
  AuthStatus _registeredInStatus = AuthStatus.notRegistered;

  AuthStatus get loggedInStatus => _loggedInStatus;

  set loggedInStatus(AuthStatus value) {
    _loggedInStatus = value;
    notifyListeners();
  }

  AuthStatus get registeredInStatus => _registeredInStatus;

  set registeredInStatus(AuthStatus value) {
    _registeredInStatus = value;
    notifyListeners();
  }*/

  Future<List<Post>> getPublications() async {
    try {
      final Response response = await get(
        Uri.parse(AppUrl.post),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        print(responseData); 
        //return responseData.map((data) => Post.fromJson(data)).toList();
        return List<Post>.from(json.decode(response.body).map((data) => Post.fromJson(data)));
      } else {
        throw Exception('Failed to get publications');
      }
    } catch (e) {
      throw e;
    }
  }
/* 
  Future<Map<String, dynamic>> register(
      String username, String email, String password) async {
    registeredInStatus = AuthStatus.registering;

    const int defaultThematic = 1;
    final Map<String, dynamic> registrationData = {
      'username': username,
      'profile_picture': '',
      'name': '',
      'description': '',
      'email': email,
      'password': password,
      'thematic_id': defaultThematic
    };

    try {
      final Response response = await post(Uri.parse(AppUrl.register),
          body: json.encode(registrationData),
          headers: {'Content-Type': 'application/json'});

      return _handleRegisterResponse(response);
    } catch (e) {
      registeredInStatus = AuthStatus.notRegistered;
      return {'status': false, 'message': 'Conenction failed'};
    }
  }

  Future<Map<String, dynamic>> _handleRegisterResponse(
      Response response) async {
    final Map<String, dynamic> responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> userData = responseData; //['data'];

      //final User authUser = User.fromJson(userData);

      //UserPreferences().saveUser(authUser);

      registeredInStatus = AuthStatus.registered;

      return {
        'status': true,
        'message': 'Successfully registered',
        'data': responseData
      };
    } else {
      registeredInStatus = AuthStatus.notRegistered;

      return {
        'status': false,
        'message': 'Registration failed',
        'data': responseData
      };
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    loggedInStatus = AuthStatus.authenticating;

    final Map<String, dynamic> loginData = {
      'email': email,
      'password': password
    };

    try {
      final Response response = await post(Uri.parse(AppUrl.login),
          body: json.encode(loginData),
          headers: {'Content-Type': 'application/json'});

      loggedInStatus = AuthStatus.loggedIn;

      return _handleLoginResponse(response);
    } catch (e) {
      loggedInStatus = AuthStatus.notLoggedIn;
      return {'status': false, 'message': 'Conenction failed'};
    }
  }

  Future<Map<String, dynamic>> _handleLoginResponse(Response response) async {
    final Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);

    if (response.statusCode == 200) {
      final Map<String, dynamic> userData = responseData; //['data'];

      //final User authUser = User.fromJson(userData);

      //UserPreferences().saveUser(authUser);

      loggedInStatus = AuthStatus.loggedIn;

      return {
        'status': true,
        'message': 'Successfully logged in',
        'data': userData
      };
    } else {
      loggedInStatus = AuthStatus.notLoggedIn;
      return {'status': false, 'message': 'Login failed', 'data': ''};
    }
  }
*/
}
