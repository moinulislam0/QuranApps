import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:quran/model/weatherModel.dart';

class WeatherController {
   String api_key = "c39d3fd6e442fb8b92c72c143bdb00cb";
  Future<WeatherModel> getWeather(String cityName) async {
   
    final url =
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&APPID=$api_key";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return WeatherModel.fromjson(jsonDecode(response.body));
    } else {
      throw Exception("failed to the the weather data");
    }
  }
}
