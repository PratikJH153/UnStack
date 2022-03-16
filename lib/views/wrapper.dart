import 'package:dailytodo/helper/display_name.dart';
import 'package:dailytodo/views/info_page.dart';
import 'package:dailytodo/views/tab_view_page.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  static const id = "/";

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  String? name;

  void gettingName() async {
    String? names = await DisplayName.getName();
    setState(() {
      name = names;
    });

    print(name);
  }

  @override
  void initState() {
    super.initState();
    gettingName();
  }

  @override
  Widget build(BuildContext context) {
    return name == null || name == "" ? InfoPage() : TabViewPage(name);
  }
}
