/// StationModel is a model that encapsulates data related to a single station under a single model
/// It contains basic data such as name, type, commune, etc.
class StationModel{
  final int libelle, nbplacesdispo, nbvelosdispo;
  final String nom, adresse, commune, etat, type, etatconnexion, datemiseajour;
  final double lon, lat;
  StationModel({required this.libelle, required this.nbplacesdispo, required this.nbvelosdispo, required this.nom, required this.adresse, required this.commune, required this.etat, required this.type, required this.lon, required this.lat, required this.etatconnexion, required this.datemiseajour});
  factory StationModel.fromJson(Map<String, dynamic> json){
    return StationModel(
      libelle: json["libelle"] as int,
      nbplacesdispo: json["nbplacesdispo"] as int,
      nbvelosdispo: json["nbvelosdispo"] as int,
      nom: json["nom"],
      adresse: json["adresse"] as String,
      commune: json["commune"] as String,
      etat: json["etat"] as String,
      type: json["type"] as String,
      lon: json["geo"]["lon"] as double,
      lat: json["geo"]["lat"] as double,
      etatconnexion: json["etatconnexion"] as String,
      datemiseajour: json["datemiseajour"],
    );
  }
}