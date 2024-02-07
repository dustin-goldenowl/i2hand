import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class _keys {
  static const String theme = 'app-theme';
  static const String token = 'token';
}

class SharedPrefs {
  factory SharedPrefs() => instance;
  SharedPrefs._internal();

  static final SharedPrefs instance = SharedPrefs._internal();
  static SharedPrefs get I => instance;
  late SharedPreferences _prefs;
  Future initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> clearSharedPref() async {
    await setToken(null);
  }

  // theme
  ThemeMode getTheme() {
    final value = _prefs.getString(_keys.theme);
    return ThemeMode.values.firstWhere(
      (e) => e.toString().toLowerCase() == '$value'.toLowerCase(),
      orElse: () => ThemeMode.system,
    );
  }

  void setTheme(ThemeMode value) {
    _prefs.setString(_keys.theme, value.toString().toLowerCase());
  }

  String getToken() {
    try {
      return _prefs.getString(_keys.token) ?? '';
    } catch (_) {}
    return '';
  }

  Future<void> setToken(String? value) async {
    if (value == null) {
      await _prefs.remove(_keys.token);
    } else {
      await _prefs.setString(_keys.token, value);
    }
  }
}
