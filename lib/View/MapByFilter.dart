import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:my_api/Controller/apiController.dart';
import 'package:my_api/Model/Device.dart';
import 'package:my_api/Model/Vehicle.dart';
import 'package:my_api/Service/apiService.dart';
import 'package:my_api/View/Home.dart';

class MapByFilter extends StatefulWidget {
  final ApiService apiService;
  

  MapByFilter({required this.apiService});

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapByFilter> {
  late final apiController controller;
  late StreamSubscription<Map<String, double>>? locationSubscription;
  List<Marker> markers = [];
Map<String, String> previousCodes = {};
Map<String, Marker> existingMarkers = {};

  MapController mapController = MapController();

  @override
  void initState() {
    super.initState();
    controller = Get.put(apiController());
    controller.initialize();

    locationSubscription =
        controller.deviceLocationStream.listen(_handleDeviceLocationUpdate);

    // Set up a timer to simulate the movement of the device every second
    Timer.periodic(Duration(seconds: 5), (Timer t) {
      _moveDevice();
    });
  }

  @override
  void dispose() {
    locationSubscription?.cancel();
    controller.closeDeviceLocationStream();
    super.dispose();
  }

void _handleDeviceLocationUpdate(Map<String, double> location) {
  setState(() {
    markers = controller.vehicules.map((car) {
      // Use 'car' instead of 'voitures' since 'car' is the variable for the outer map
      return Marker(
        width: 30.0,
        height: 30.0,
        point: LatLng(
          double.parse(car.latitude),
          double.parse(car.longitude),
        ),
        builder: (context) => GestureDetector(
          onTap: () async {
            LatLng markerLocation = LatLng(double.parse(car.latitude), double.parse(car.longitude));

            // Reverse geocode to get the address
            List<Placemark> placemarks =
                await placemarkFromCoordinates(markerLocation.latitude, markerLocation.longitude);

            // Show a pop-up with information
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Vehicle Information'), // Updated title to 'Vehicle Information'
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('id: ${car.id}'),
                    Text('Code: ${car.code}'),
                    Text('Kilometrage: ${car.kilometrage}'),
                    Text('Fuel level: ${car.fuelLevel}'),
                    Text('Effective speed: ${car.effectiveSpeed}'),
                    Text('Engine RPM: ${car.engineRpm}'),
                    Text('Engine temperature: ${car.engineTemperature}'),
                    Text('Charge moteur: ${car.chargeMoteur}'),
                    Text('Batterie Voltage: ${car.batterieVoltage}'),
                    Text('Latitude: ${markerLocation.latitude}'),
                    Text('Longitude: ${markerLocation.longitude}'),
                    Text('Address: ${placemarks.isNotEmpty ? placemarks[0].name : 'Unknown'}'),
                    // Add more information as needed
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              ),
            );
          },
          child: Container(
            child: Image.asset(
              'images/images.png',
              width: 30.0,
              height: 30.0,
            ),
          ),
        ),
      );
    }).toList();
  });
}

  Future<void> _moveDevice() async {
    await controller.getUserInfo();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<Map<String, double>>(
            stream: controller.deviceLocationStream,
            builder: (context, snapshot) {
              return FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  center: LatLng(36.8065, 10.1815),
                  zoom: 7.0,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayerOptions(markers: markers),
                ],
              );
            },
          ),
        ),
        MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          minWidth: 500,
          color: Colors.blue,
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              ),
            );
          },
          child: Text("Return back", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
