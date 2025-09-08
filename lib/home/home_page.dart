import 'package:flutter/material.dart';
import 'package:weather_app/Components/weather_card.dart';
import 'package:weather_app/weather_model.dart';

class HomeBody extends StatelessWidget {
  final Weather? weather;
  final String? city;
  final String? locality;
  final double? lat;
  final double? long;

  const HomeBody({
    super.key,
    required this.weather,
    required this.city,
    required this.locality,
    required this.lat,
    required this.long,
  });

  @override
  Widget build(BuildContext context) {
    final Color textColor = (weather == null)
        ? Colors.white
        : weather!.description.toLowerCase().contains("clear")
        ? Colors.black
        : Colors.white;

    final gradient = (weather == null)
        ? LinearGradient(colors: [Colors.grey.shade800, Colors.grey.shade400])
        : weather!.description.toLowerCase().contains("rain")
        ? LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.blueGrey.shade800,
        Colors.blueGrey.shade400,
        Colors.blue.shade300,
      ],
    )
        : weather!.description.toLowerCase().contains("clear")
        ? LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.orangeAccent, Colors.blueAccent],
    )
        : LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.blueGrey.shade800,
        Colors.blueGrey.shade300,
      ],
    );

    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(gradient: gradient),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Home",
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Latitude: ${lat?.toStringAsFixed(4) ?? "--"}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: textColor,
                      ),
                    ),
                    Text(
                      "Longitude: ${long?.toStringAsFixed(4) ?? "--"}",
                      style: TextStyle(
                        color: textColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 40),
            Text(
              "Your City is ${city ?? "Unknown"}",
              style: TextStyle(
                color: textColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 4.2,
              ),
            ),
            Text(
              "Your Locality is ${locality ?? "Unknown"}",
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
              ),
            ),
            const SizedBox(height: 30),
            if (weather != null) WeatherCard(weather: weather!),
          ],
        ),
      ),
    );
  }
}
