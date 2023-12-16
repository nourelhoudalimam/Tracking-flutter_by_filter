import 'package:my_api/Model/locatime.dart';

class Device{
  
  String id;
   String code;
String longitude;
String latitude;
int effective_speed;
int engine_rpm;
int engine_temperature;
int fuel_level;
int kilometrage;
int batterie_voltage;
int charge_moteur;
String timestamp;
String filter;
Localtime engine_on_time;
Device({required this.timestamp,required this.filter,required this.charge_moteur,required this.engine_on_time,required this.kilometrage,required this.id,required this.code,required this.latitude,required this.longitude,required this.batterie_voltage,required this.effective_speed,required this.engine_rpm,required this.engine_temperature ,required this.fuel_level});
 factory Device.fromJson( dynamic json) {
    return Device(
    filter  : json['filter'] ,

    id: json['id'] ?? "",
   code  : json['code'] ,
   longitude    : json['longitude'] ?? "",
   latitude      : json['latitude'] ?? "",
   effective_speed        : json['effective_speed'] ?? 0,
  engine_rpm           : json['engine_rpm'] ?? 0,
   engine_temperature             : json['engine_temperature'] ?? 0,
    fuel_level:   json['fuel_level'] ?? 0,

   kilometrage: json['kilometrage'] ?? 0,
   batterie_voltage: json['batterie_voltage'] ?? 0,
   charge_moteur: json['charge_moteur'] ?? 0,
      engine_on_time: Localtime.fromJson(json['engine_on_time'] ?? {}),
   timestamp: json['timestamp'] ??"",

    );

  }
}