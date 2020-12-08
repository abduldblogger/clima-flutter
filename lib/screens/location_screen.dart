import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/WeatherHelper.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  final weatherData;

  LocationScreen(this.weatherData);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int _temperature;
  String _weatherIcon;
  WeatherModel _weatherModel = WeatherModel();
  String _message;
  String _cityName;

  @override
  void initState() {
    super.initState();
    updateUI(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      fetchLocationAndUpdateData();
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      fetchCityUpdateData(typedName);
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$_temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$_weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$_message in $_cityName',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateUI(weatherData) {
    if (weatherData == null) {
      _temperature = 0;
      _weatherIcon = "";
      _message = kDataFetchFailMsg;
      _cityName = "";
    } else {
      double temp = weatherData['main']['temp'];
      _temperature = temp.toInt() - 273;
      int id = weatherData['weather'][0]['id'];
      _weatherIcon = _weatherModel.getWeatherIcon(id);
      _message = _weatherModel.getMessage(_temperature);
      _cityName = weatherData['name'];
    }
  }

  void fetchLocationAndUpdateData() async {
    Location location = Location();
    await location.getLocation();
    WeatherHelper weatherHelper = WeatherHelper();
    var weatherData = await weatherHelper.getData(location);
    setState(() {
      updateUI(weatherData);
    });
  }

  void fetchCityUpdateData(String cityName) async {
    if (cityName != null) {
      WeatherHelper weatherHelper = WeatherHelper();
      var weatherData = await weatherHelper.getDataFromCityName(cityName);
      setState(() {
        updateUI(weatherData);
      });
    }
  }
}
