import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/weather_model.dart';

class WeatherCard extends StatefulWidget {
  final Weather weather;
  const WeatherCard({required this.weather, super.key});

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  @override
  Widget build(BuildContext context) {
    String formatTime(int timestamp)  {
      final time = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      return DateFormat('hh:mm a').format(time);
    }
    Weather _weather = widget.weather;
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Lottie.asset(
                _weather.description.toLowerCase().contains("rain")
                    ? "assets/rain.json"
                    : _weather.description.toLowerCase().contains("clear")
                    ? "assets/sunny.json"
                    : "assets/cloudy.json",
                height: 200,
                width: 200,
              ),
              Text(
                _weather.cityName,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.white
                ),
              ),
              const SizedBox(height: 10,),
              Text(
                "${_weather.temperature.toStringAsFixed(1)}°C",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
              const SizedBox(height: 10,),
              Text(
                _weather.description,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.normal,
                  color: Colors.white
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                   "Humidity : ${ _weather.humidity}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.white
                    ),
                  ),
                  Text(
                    "Wind Speed : ${ _weather.windSpeed} m/s",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.white
                    ),

                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Icon(Icons.wb_sunny_outlined, color: Colors.orange,),
                      Text(
                        "Sunrise : ${formatTime(_weather.sunrise)}",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.white
                        ),
                      ),
                    ],
                  ),
                    Column(
                      children: [
                        Icon(Icons.nights_stay_outlined, color: Colors.deepPurple,),

                        Text(
                          "Sunset : ${formatTime(_weather.sunset)}",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.white
                        )
                                          ),
                      ],
                    )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
