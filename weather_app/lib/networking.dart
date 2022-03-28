import 'dart:convert';

import 'package:weather_app/weather_info.dart';
import 'package:http/http.dart' as http;

Future<WeatherInfo> getWeatherInfo({required String location}) async {
  var url = Uri.http("api.weatherapi.com", "/v1/current.json",
      {"key": "ac47448b620f4482868174026212712", "q": location, "aqi": "no"});

  var response = await http.get(url);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    return WeatherInfo.fromJson(json: jsonResponse);
  } else if (response.statusCode == 400) {
    var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    throw Exception(jsonResponse['error']['message']);
  } else {
    throw Exception('Unknown Error Found');
  }
}
