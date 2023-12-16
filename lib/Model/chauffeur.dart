
class Chauffeur{
  String id;
   String filter;
String fullname;
String cin;
String email;
 String permis;
String tele;
String fonction;
  int score_avg;
Chauffeur({required this.id,required this.filter,required this.fullname,required this.cin,required this.email,required this.permis,required this.tele,required this.fonction ,required this.score_avg});
 factory Chauffeur.fromJson( dynamic json) {
    return Chauffeur(
      id: json['id'] ?? "",
   filter   : json['filter'] ?? "",
    fullname    : json['fullname'] ?? "",
   cin       : json['cin'] ?? "",
   email         : json['email'] ?? "",
  permis            : json['permis'] ?? "",
   tele             : json['tele'] ?? "",
    fonction:   json['fonction'] ?? "" ,

    score_avg: json['score_avg'] ?? 0,

    );

  }
   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'filter': filter,
      'fullname': fullname,
      'cin': cin,
      'email': email,
      'permis': permis,
      'tele': tele,
      'fonction': fonction,
      'score_avg': score_avg,
    };
  }
}