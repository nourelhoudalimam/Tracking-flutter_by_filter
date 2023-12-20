import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:my_api/Controller/apiController.dart';
import 'package:my_api/Service/apiService.dart';
import 'package:my_api/View/InputCode.dart';

class MapWidget extends StatefulWidget {
 String codeValue;
  final ApiService apiService;

  MapWidget({required this.codeValue, required this.apiService});

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late final apiController controller;
  late StreamSubscription<Map<String, double>>? locationSubscription;
  LatLng? markerPosition;
  MapController mapController = MapController(); // Added MapController

  @override
  void initState() {
    super.initState();
    controller = Get.put(apiController());
    controller.initializeListdevice(widget.codeValue);

    locationSubscription = controller.deviceLocationStream.listen(_handleDeviceLocationUpdate);

    // Set up a timer to simulate the movement of the device every second
    Timer.periodic(Duration(seconds: 5), (Timer t) {
      _moveDevice();
    });
  }

  Future<void> _clearData() async {
    widget.codeValue = '';
    await controller.clearCodeDevice();
  }

  @override
  void dispose() {
    // Dispose of the timer to prevent memory leaks
    locationSubscription?.cancel();
    controller.closeDeviceLocationStream();
    super.dispose();
  }

  void _handleDeviceLocationUpdate(Map<String, double> location) {
    setState(() {
      if (controller.devices.isNotEmpty) {
        markerPosition = LatLng(
          location['latitude'] ?? 0.0,
          location['longitude'] ?? 0.0,
        );
        print("Track marker position: $markerPosition");
                mapController.move(markerPosition!, 7.0);

      }
    });
  }

 Future<void> _moveDevice() async {
  await controller.getVehicleLocation(widget.codeValue);
  setState(() {}); // Trigger a rebuild to update marker positions
}



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<Map<String, double>>(
            stream: controller.deviceLocationStream,
            builder: (context, snapshot) {
              print('Current markerPosition: $markerPosition');

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
                  MarkerLayerOptions(
                    markers: [
                      if (markerPosition != null)
                        Marker(
                          width: 30.0,
                          height: 30.0,
                          point: LatLng(
                            markerPosition!.latitude,
                            markerPosition!.longitude,
                          ),
                          builder: (context) => GestureDetector(
                            onTap: () async {
                              // Handle marker tap event
                            },
                            child: Container(
                              child: Image.asset(
                                'images/images.png',
                                width: 30.0,
                                height: 30.0,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
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
            await _clearData();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => inputCode(),
              ),
            );
          },
          child: Text("Return back", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
