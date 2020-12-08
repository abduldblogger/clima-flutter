import 'package:geolocator/geolocator.dart';

class Location {
  double _latitude;
  double _longitude;

  Future<void> getLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      _latitude = position.latitude;
      _longitude = position.longitude;
      print(position);
    } catch (e) {
//      throw Exception('Can\'t find position');
      print('Can\'t find position');
    }
  }

  double getLongitude() {
    return _longitude;
  }

  double getLatitude() {
    return _latitude;
  }
}
