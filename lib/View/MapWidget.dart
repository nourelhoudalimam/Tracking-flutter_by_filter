import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:my_api/Controller/apiController.dart';  // Import your apiController
import 'package:my_api/Service/apiService.dart';
import 'package:my_api/View/InputCode.dart';  // Import your Device model

class MapWidget extends StatefulWidget {
  String codeValue;
  final ApiService apiService;
  late final apiController controller;

  MapWidget({required this.codeValue, required this.apiService});

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late StreamSubscription<Map<String, double>> locationSubscription;
  late Timer timer;
  LatLng? markerPosition; // Define markerPosition here
 Future<void> _clearData() async {
    widget.codeValue = '';
    await widget.controller.clearCodeDevice(); // Add a method in apiController to clear the list
  }
  @override
  void initState() {
    super.initState();
    widget.controller = Get.put(apiController());
    widget.controller.initializeListdevice(widget.codeValue);

    // Create a single subscription for the device location stream
   locationSubscription = widget.controller.deviceLocationStream.listen((location) {
      updateDeviceLocation(location);
    });

    // Set up a timer to simulate the movement of the device every second
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      moveDevice();
    });
  }

  @override
  void dispose() {
    // Dispose of the timer to prevent memory leaks
    timer.cancel();

    // Dispose of the stream subscription
    locationSubscription.cancel();

    super.dispose();
  }

void updateDeviceLocation(Map<String, double> location) {
    // Update your marker position or do any other necessary updates
    print('Received new location: $location');
    setState(() {
      markerPosition = LatLng(location['latitude']!, location['longitude']!);
    });
  }

 Future<void> moveDevice() async {
  try {
    await widget.controller.getVehicleLocation(widget.codeValue);

    // Assuming your controller has the updated coordinates
    setState(() {
      if (widget.controller.devices.isNotEmpty) {
        // Assuming the first device in the list is the one you want to track
        markerPosition = LatLng(
          double.parse(widget.controller.devices[0].latitude),
          double.parse(widget.controller.devices[0].longitude),
        );
      }
    });
  } catch (error) {
    print('Error moving device: $error');
  }
}

  @override
  Widget build(BuildContext context) {
    return Column(
   children:[ Expanded(child:FlutterMap(
      options: MapOptions(
        center: LatLng(36.8065, 10.1815), // Centered around Tunisia
        zoom: 7.0, // Default zoom level
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayerOptions(
          markers: [
            if (markerPosition != null)
              Marker(
                width: 30.0,
                height: 30.0,
                point: markerPosition!,
                builder: (context) => GestureDetector(
                  onTap: () async {
                    // Handle marker tap event
                  },
                  child: Container(
                    child: Image.asset(
                      'images/images.png', // Replace with the path to your custom 3D device image
                      width: 30.0,
                      height: 30.0,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    )), MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                minWidth: 500,
                color: Colors.blue,
                onPressed: () async {
                  // Pop the inputFiltre screen
                  await _clearData();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => inputCode(),
                    ),
                  );
                },
                child: Text("Return back", style: TextStyle(color: Colors.white)),
              ),]);
  }
}
