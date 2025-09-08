import 'package:flutter/material.dart';

class Weather{
  final String cityName;
  final double temperature;
  final String description;
  final int humidity;
  final double windSpeed;
  final int sunrise;
  final int sunset;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.sunrise,
    required this.sunset,
});
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: (json['main']['temp'] - 273.15), // Kelvin → Celsius
      description: json['weather'][0]['description'], // weather is a list
      humidity: json['main']['humidity'], // humidity is in 'main'
      windSpeed: (json['wind']['speed']).toDouble(),
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
    );
  }


}