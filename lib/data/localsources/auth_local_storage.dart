import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalStorage {
  final String tokenKey = 'token';

  Future<String> saveToken(String token) async {
    final pref = await SharedPreferences.getInstance();

    await pref.setString('token', token);
    return token;
  }

  Future<String> getToken() async {
    final pref = await SharedPreferences.getInstance();

    return pref.getString('token')!;
  }

  Future<bool> isTokenExist() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('token') != null;
  }

  Future<bool> removeToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.remove(tokenKey);
  }
}
