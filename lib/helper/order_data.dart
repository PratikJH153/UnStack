import 'package:shared_preferences/shared_preferences.dart';

class OrderData {
  static void setOrder(List<String> order) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('order', order);
  }

  static Future<List<int?>> getOrder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<int?> orderList =
        prefs.getStringList('order')!.map((e) => int.parse(e)).toList();
    return orderList;
  }
}
