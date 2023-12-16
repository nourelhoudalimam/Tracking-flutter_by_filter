class Localtime{
 String hour;
String minute;
String second;
String nano;
  Localtime({required this.hour,required this.minute,required this.second,required this.nano});

factory Localtime.fromJson(dynamic json) {
    return Localtime(
      hour: json['hour'] ?? 0,
      minute: json['minute'] ?? 0,
      second: json['second'] ?? 0,
      nano: json['nano'] ?? 0,
    );
  }}