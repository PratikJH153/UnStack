import 'package:shared_preferences/shared_preferences.dart';

class DisplayName {
  static void setName(String displayName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('displayName', displayName);
  }

  static Future<String?> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('displayName');
  }
}
