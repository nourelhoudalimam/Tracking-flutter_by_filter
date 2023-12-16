import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:my_api/Model/Device.dart';
import 'package:my_api/Model/chauffeur.dart';


class apiController extends GetxController{
  List<Chauffeur> chauffeur=[];
    final _deviceLocationController = StreamController<Map<String, double>>.broadcast();
  Stream<Map<String, double>> get deviceLocationStream => _deviceLocationController.stream;
  List<Device> devices=[];
  Map<String, double>? lastLocation;

Future<void> initializeJWT() async {
    try {
    
     // await exportDataToJsonAndPost();
       await getJwt();
  
  } catch (e) {
    print('Erreur lors de la récupération de token : $e');
  }
  }
Future<void> initializeListChauffeur(String filter) async {
    try {
    
     // await exportDataToJsonAndPost();
       await getChauffeur(filter);
  
  } catch (e) {
    print('Erreur lors de la récupération des chauffeurs : $e');
  }
  }
Future<void> initializeListChauffeurparID(String id) async {
    try {
    
     // await exportDataToJsonAndPost();
       await getChauffeurparID(id);
  
  } catch (e) {
    print('Erreur lors de la récupération des chauffeurs : $e');
  }
  }
  Future<void> initializeListdevice(String code) async {
    try {
    
     // await exportDataToJsonAndPost();
       await getVehicleLocation(code);
  
  } catch (e) {
    print('Erreur lors de la récupération des positions : $e');
  }
  }
Future<void> initializeListdeviceByFilter(String filter) async {
    try {
    
     // await exportDataToJsonAndPost();
       await getVehicleLocationByFilter(filter);
  
  } catch (e) {
    print('Erreur lors de la récupération des positions : $e');
  }
  }

Future<List<dynamic>> fetchData() async {
  final response = await http.get(Uri.parse('http://192.168.1.26:3000/jwt'));

  if (response.statusCode == 200 || response.statusCode == 201) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load data');
  }
}

Future<String?> getJwt() async {

List<dynamic> jsonDataList = await fetchData();
if (jsonDataList.isNotEmpty) {
  String jwt = jsonDataList[1]['jwt'];
  return jwt;
} else {
  throw Exception('Empty or invalid response');
}}
Future<void> getChauffeur(String filter) async {
  try {
    final String? jwt = await getJwt();
    final apiUrl = 'http://35.180.211.234:1111/api/cubeIT/NaviTrack/rest/chauffeurs/get-list-filtered/$filter';

    if (jwt != null) {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $jwt'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = json.decode(response.body);

        // Check if the response is not empty
        if (data.isNotEmpty) {
          try {
            chauffeur = data.map((json) => Chauffeur.fromJson(json)).toList();
            update();
          } catch (e) {
            print('Error mapping JSON to chauffeur: $e');
          }
        } else {
          print('Empty response received');
        }
      } else {
        print('Échec de la récupération des chauffeurs. Erreur: ${response.reasonPhrase},${response.statusCode}');
        // Handle other HTTP status codes if needed
      }
    } else {
      print('JWT non disponible');
      throw Exception('JWT non disponible');
    }
  } catch (e) {
    print('Erreur lors de la récupération des chauffeurs: $e');
    // Handle errors, e.g., display a message to the user
  }
}
Future<void> getVehicleLocation(String deviceCode) async {
  try {
    final String? jwt = await getJwt();
    final apiUrl = 'http://35.180.211.234:1111/api/cubeIT/NaviTrack/rest/device/webflux/stream/tracking?code=$deviceCode';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $jwt'});
   

    if (response.statusCode == 200 || response.statusCode == 201) {
if (response.body.isNotEmpty) {

      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        try{
      devices = data.map((json) => Device.fromJson(json)).toList();
  } catch (e) {
            print('Error mapping JSON to device: $e');
          }
      update();
      } else {
        throw Exception('No data found for the given device code.');
      }
      } else {
  throw Exception('Empty response from the server.');
}  
    } else {
      throw Exception('Failed to load data. Status code: ${response.statusCode},${response.reasonPhrase},${response.body}');
    }
  } catch (e) {
    print('Error fetching vehicle location: $e');
    throw Exception('Error fetching vehicle location: $e');
  }
}

Future<void> getVehicleLocationByFilter(String filter) async {
  try {
    final String? jwt = await getJwt();
    final apiUrl = 'http://35.180.211.234:1111/api/cubeIT/NaviTrack/rest/device/webflux/stream/track-all-by-filter?filter=$filter';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $jwt'});
   

    if (response.statusCode == 200 || response.statusCode == 201) {
if (response.body.isNotEmpty) {

      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        try{
      devices = data.map((json) => Device.fromJson(json)).toList();
  } catch (e) {
            print('Error mapping JSON to device: $e');
          }
      update();
      } else {
        throw Exception('No data found for the given device code.');
      }
      } else {
  throw Exception('Empty response from the server.');
}  
    } else {
      throw Exception('Failed to load data. Status code: ${response.statusCode},${response.reasonPhrase},${response.body}');
    }
  } catch (e) {
    print('Error fetching vehicle location: $e');
    throw Exception('Error fetching vehicle location: $e');
  }
}


Future<void> getChauffeurparID(String id) async {
  try {
    final String? jwt = await getJwt();
    final apiUrl = 'http://35.180.211.234:1111/api/cubeIT/NaviTrack/rest/chauffeurs/get-one/$id';

    if (jwt != null) {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $jwt'},
      );

      if (response.statusCode == 200 || response.statusCode == 201 ) {
        final Map<String,dynamic> data = json.decode(response.body);

        
          // Check if the response is a map
          if (data.isNotEmpty) {
            try {
              chauffeur = [Chauffeur.fromJson(data)];
              update();
            } catch (e) {
              print('Error mapping JSON to chauffeur: $e');
            }
          } else {
            print('Empty response received');
          }
        }else if (response.statusCode == 404) {
  print('Chauffeur not found');}
       else {
        print('Échec de la récupération des chauffeurs. Erreur: ${response.headers},${response.reasonPhrase},${response.statusCode},${response.body}');
        // Handle other HTTP status codes if needed
      }
    } else {
      print('JWT non disponible');
      throw Exception('JWT non disponible');
    }
  } catch (e) {
    print('Erreur lors de la récupération des chauffeurs: $e');
    // Handle errors, e.g., display a message to the user
  }
}

Future<void> deleteChauffeur(String chauffeurId) async {
  try {
    final String? jwt = await getJwt();
    final apiUrl = 'http://35.180.211.234:1111/api/cubeIT/NaviTrack/rest/chauffeurs/delete-one/$chauffeurId';

    if (jwt != null) {
      final response = await http.delete(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $jwt'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Chauffeur deleted successfully
        print('Chauffeur deleted successfully');
        // You may want to update your UI or perform additional actions
      } else {
        print('Échec de la suppression du chauffeur. Erreur: ${response.reasonPhrase}');
        // Handle other HTTP status codes if needed
      }
    } else {
      print('JWT non disponible');
      throw Exception('JWT non disponible');
    }
  } catch (e) {
    print('Erreur lors de la suppression du chauffeur: $e');
    // Handle errors, e.g., display a message to the user
  }
}

 Future<void> clearChauffeurList()async {
   chauffeur.clear(); // Assuming chauffeur is your list of chauffeurs in apiController
    update(); // Notify the listeners that the list has been cleared
  }
   Future<void> clearCodeDevice()async {
   devices.clear(); // Assuming chauffeur is your list of chauffeurs in apiController
    update(); // Notify the listeners that the list has been cleared
  }
}
