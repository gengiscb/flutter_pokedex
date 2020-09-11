import 'package:flutter/material.dart';
import 'package:pokedex/models/status_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  Status _status = Status.Uninitialized;
  bool _firstOpen = true;
  bool _loggedIn = false;
  bool _loading = false;

  Status get status => _status;
  bool get firstOpen => _firstOpen;
  bool get loading => _loading;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  AuthProvider.initialize() {
    readPrefs();
  }

  Future<void> readPrefs() async {
    //Future use just for async call simulation.
    await Future.delayed(Duration(seconds: 1)).then((v) async {
      final SharedPreferences prefs = await _prefs;
      //prefs.clear();
      _firstOpen = prefs.getBool('firstOpen') ?? true;
      _loggedIn = prefs.getBool('loggedIn') ?? false;
      //notifyListeners();
      if (!_loggedIn) {
        _status = Status.Unauthenticated;
      } else {
        _status = Status.Authenticated;
      }

      if (_firstOpen) {
        await prefs.setBool("firstOpen", false);
      }
      notifyListeners();
    });
  }

  Future<void> signIn() async {
    final SharedPreferences prefs = await _prefs;
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await Future.delayed(const Duration(seconds: 1));
      prefs.setBool("loggedIn", true);
      _status = Status.Authenticated;
      clearValues();
      notifyListeners();
    } catch (e) {
      print(e);
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
    }
  }

  Future introEnd() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool("firstOpen", false);
    _firstOpen = false;
    _status = Status.Unauthenticated;
    notifyListeners();
  }

  Future signOut() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool("loggedIn", false);
    _status = Status.Unauthenticated;
    notifyListeners();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String passwordValidator(String value) {
    if (value.length < 6) {
      return 'Password must be longer than 6 characters';
    }
    return null;
  }

  void clearValues() {
    emailController.text = '';
    passwordController.text = '';
  }
}
