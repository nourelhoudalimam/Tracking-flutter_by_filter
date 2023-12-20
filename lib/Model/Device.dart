
class Device {
  String id;
  String code;
  String longitude;
  String latitude;
  int effectiveSpeed;
  int engineRpm;
  int engineTemperature;
  int fuelLevel;
  int kilometrage;
  int batterieVoltage;
  int chargeMoteur;
  String timestamp;
  List<int> engineOnTime;

  Device({
    required this.id,
    required this.code,
    required this.longitude,
    required this.latitude,
    required this.effectiveSpeed,
    required this.engineRpm,
    required this.engineTemperature,
    required this.fuelLevel,
    required this.kilometrage,
    required this.batterieVoltage,
    required this.chargeMoteur,
    required this.timestamp,
    required this.engineOnTime,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'] ?? "",
      code: json['code'] ?? "",
      longitude: json['longitude'] ?? "",
      latitude: json['latitude'] ?? "",
      effectiveSpeed: json['effective_speed'] ?? 0,
      engineRpm: json['engine_rpm'] ?? 0,
      engineTemperature: json['engine_temperature'] ?? 0,
      fuelLevel: json['fuel_level'] ?? 0,
      kilometrage: json['kilometrage'] ?? 0,
      batterieVoltage: json['batterie_voltage'] ?? 0,
      chargeMoteur: json['charge_moteur'] ?? 0,
      timestamp: json['timestamp'] ?? "",
      engineOnTime: List<int>.from(json['engine_on_time'] ?? []),
    );
  }
   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code':code,
      'longitude': longitude,
      'latitude': latitude,
      'kilometrage': kilometrage,
      'engine_rpm': engineRpm,
      'engine_on_time': engineOnTime,
      'engine_temperature': engineTemperature,
      'fuel_level': fuelLevel,
      'effective_speed': effectiveSpeed,
      'timestamp': timestamp,
'charge_moteur':chargeMoteur,
'batterie_voltage':batterieVoltage
    };
  }
}
