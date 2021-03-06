import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home-content.dart';
import 'package:flutter_app/pages/passwordReset-page.dart';
import 'package:flutter_app/pages/profile-page.dart';
import 'package:flutter_app/pages/task-history-page.dart';
import 'package:flutter_app/pages/tasks-page.dart';
import "./pages/login-page.dart";
import "./pages/home-page.dart";
import "./pages/filters.dart";
import "./services/auth.service.dart";
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import './pages/verify_ID.dart';
import './pages/task-history-page.dart';
import './pages/profile-page.dart';

import './pages/chatscreen.dart';
import './pages/chat.dart';

import './pages/home-content.dart';






AuthService appAuth = new AuthService();
final storage = new FlutterSecureStorage();
FlutterSecureStorage  getStorage() {
  return storage;
}

void main() async {

  // Set default home.
  Widget _defaultHome = new LoginPage();




  // Run app!
  runApp(new MaterialApp(
    title: 'App',
    home: _defaultHome,
    routes: <String, WidgetBuilder>{
      // Set routes for using the Navigator.
      '/home': (BuildContext context) => new HomePage(),
      '/home-content' : (BuildContext context) => new HomeContent(),
      '/login': (BuildContext context) => new LoginPage(),
      '/tasks': (BuildContext context) => new TasksPage(),
      '/passwordReset': (BuildContext context) => new PasswordReset(),
      '/history': (BuildContext context) => new HistoryPage(),
      '/profile': (BuildContext context) =>  ProfilePage(),
      '/filters': (BuildContext context) => new FilterPage(),
      '/verifyID': (BuildContext context) => new VerifyID(),
      '/chat': (BuildContext context) => new ChatPage(),

    },
  ));
}
