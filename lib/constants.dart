import 'package:flutter/material.dart';
import 'package:vlille/home_dart.dart';

/// pages
class PageNames{
  static const String home = "home";
}

/// api consts
class ApiDetails{
  static const urlPrefix = "https://opendata.lillemetropole.fr/api/explore/v2.1/catalog/datasets/vlille-realtime/records?";
}

/// page builders
class PageBuilders{
  static WidgetBuilder homeBuilder = (BuildContext context) => const HomePage();
}

WidgetBuilder homeBuilder = (BuildContext context) => const HomePage();