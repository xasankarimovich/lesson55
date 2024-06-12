import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthHttpService {
  final String _apiKey = 'AIzaSyDnjBbxj7tCqgfbeLJQFPg94y6cCa5mUpc';

  Future<void> _authenticate({
    required String email,
    required String password,
    required String query,
  }) async {
    Uri url = Uri.parse(
      'https://identitytoolkit.googleapis.com/v1/accounts:$query?key=$_apiKey',
    );

    try {
      final http.Response response = await http.post(
        url,
        body: jsonEncode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw (data['error']['message']);
      }
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('token', data['idToken']);
      await sharedPreferences.setString('userId', data['localId']);
      DateTime expiryDate = DateTime.now().add(
        Duration(seconds: int.parse(data['expiresIn'])),
      );
      await sharedPreferences.setString('expiryDate', expiryDate.toString());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> register(
      {required String email, required String password}) async {
    await _authenticate(
      email: email,
      password: password,
      query: 'signUp',
    );
  }

  Future<void> login({required String email, required String password}) async {
    await _authenticate(
      email: email,
      password: password,
      query: 'signInWithPassword',
    );
  }

  Future<void> resetPassword({required String email}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String? userToken = sharedPreferences.getString('token');
    final Uri url = Uri.parse(
      'https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=$_apiKey',
    );
    try {
      if (userToken == null) {
        throw 'user not found';
      }
      final response = await http.post(
        url,
        body: jsonEncode({
          'requestType': 'PASSWORD_RESET',
          'email': email,
        }),
      );
      if (response.statusCode != 200) {
        throw jsonDecode(response.body)['error']['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> checkAuth() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');

    if (token == null) {
      return false;
    }

    DateTime expiryDate =
        DateTime.parse(sharedPreferences.getString('expiryDate')!);

    return expiryDate.isAfter(DateTime.now());
  }
}
