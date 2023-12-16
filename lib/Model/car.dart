import 'dart:math';
import 'dart:ui';

class Car {
  
  double latitude;
  double longitude;
Color markerColor;
  Car({required this.latitude, required this.longitude,required this.markerColor});
  

  bool isWithinTunisiaBounds() { return latitude >= 36.70 && latitude <= 36.92 && longitude >= 10.03 && longitude <= 10.2;}
}

List<Car> generateCarDataset(int numberOfCars) {
  Random random = Random();
  List<Car> cars = [];

  for (int i = 0; i < numberOfCars; i++) {
   double randomLatitude = 36.70 + random.nextDouble() * (36.92 - 36.70); // Latitude within Grand Tunis bounds
    double randomLongitude = 10.03 + random.nextDouble() * (10.33 - 10.03); // Longitude within Grand Tunis bounds
Color randomColor = Color.fromRGBO(
      random.nextInt(256), // Red component
      random.nextInt(256), // Green component
      random.nextInt(256), // Blue component
      1.0, // Opacity
    );

    Car car = Car(latitude: randomLatitude, longitude: randomLongitude,markerColor: randomColor);

    // Check if the generated coordinates are within Tunisia bounds
    if (car.isWithinTunisiaBounds()) {
      cars.add(car);
    }
  }

  return cars;
}

 
