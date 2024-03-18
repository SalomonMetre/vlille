import 'package:flutter/material.dart';
import 'package:vlille/constants.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: PageNames.home,
    routes: <String, WidgetBuilder>{
      PageNames.home: PageBuilders.homeBuilder,
    },
  ));
}
