import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherServices{

  final String apiKey = '34c2470dc2e69826cc166e827693897b';
  Future<Weather> getWeather(String cityName) async{
    final url =  Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey");
    final response = await http.get(url);

    if(response.statusCode == 200){
      return Weather.fromJson(json.decode(response.body));
    }else{
      throw Exception('Failed to load weather data');
    }
  }
}