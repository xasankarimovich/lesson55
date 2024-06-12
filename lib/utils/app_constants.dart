import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConstants {
  static ThemeMode themeMode = ThemeMode.light;
  static String imageUrl =
      'https://cdn.pixabay.com/photo/2016/06/14/19/43/cosmos-1457362_1280.jpg';
  static String language = 'UZ';
  static Color appColor = Colors.teal;

  static String password = '1234';
  static Color textColor = Colors.black;
  static double textSize = 14;

  Future<void> setConstants() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    /// theme
    String isDark = preferences.getString('isDark') ?? 'false';
    themeMode = isDark == 'true' ? ThemeMode.dark : ThemeMode.light;

    /// image
    imageUrl = preferences.getString('image') ??
        'https://cdn.pixabay.com/photo/2016/06/14/19/43/cosmos-1457362_1280.jpg';

    language = preferences.getString('language') ?? 'UZ';

    /// color
    int colorValues = preferences.getInt('app-color') ?? 1;
    appColor = colorValues == 1 ? Colors.teal : Color(colorValues);

    /// password
    password = preferences.getString('password') ?? '1111';

    /// text settings
    String box = preferences.getString('text-val') ?? 'null';
    if (box != 'null') {
      final Map<String, dynamic> temp = jsonDecode(box);
      textSize = temp['text-size'];
      textColor = Color(temp['text-color']);
    }
  }
}
