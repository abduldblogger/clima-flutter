import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/utilities/constants.dart';

class WeatherHelper {
  Future<dynamic> getDataFromCityName(String cityName) async {
    Networking networking =
        Networking('$kOpenWeatherApiEndpoint?q=$cityName&appid=$kApiKey');
    return await networking.getData();
  }

  Future<dynamic> getData(Location location) async {
    Networking networking =
        Networking('$kOpenWeatherApiEndpoint?lat=${location.getLatitude()}&'
            'lon=${location.getLongitude()}&appid=$kApiKey');
    return await networking.getData();
  }
}
