import 'package:shared_preferences/shared_preferences.dart';

void storeServerIP(String ip) async {
  SharedPreferences sp = await SharedPreferences.getInstance();

  sp.setString("serverIP", ip);
}

void storeServerPort(String port) async {
  SharedPreferences sp = await SharedPreferences.getInstance();

  sp.setString("serverPort", port);
}

Future<String?> loadServerIP() async {
  SharedPreferences sp = await SharedPreferences.getInstance();

  return (sp.getString("serverIP"));
}

Future<String?> loadServerPort() async {
  SharedPreferences sp = await SharedPreferences.getInstance();

  return (sp.getString("serverPort"));
}