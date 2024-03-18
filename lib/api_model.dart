import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vlille/constants.dart';

/// ApiModel is a model used to make HTTP requests to the provided API
/// Avec ApiModel, l'on est en mesure des faire des requêtes HTTP vers l'API de Vlille
class ApiModel{

  /// getDate gives the API data
  /// If the station string is empty, general data about Lille is returned
  /// Dans le cas contraire, on obtient des données liées à une station précise
  static Future<List> getData (int limit, [String station=""]) async{
    String url = station.isEmpty ? "${ApiDetails.urlPrefix}limit=$limit&refine=commune:\"LILLE\"" : "${ApiDetails.urlPrefix}limit=$limit&refine=commune:\"LILLE\"&refine=nom:\"$station\"";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final data = response.body;
    final finalData = (json.decode(data) as Map)["results"] as List;
    return finalData;
  }
}