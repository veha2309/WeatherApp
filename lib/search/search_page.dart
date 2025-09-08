import 'package:flutter/material.dart';
import 'package:weather_app/Components/weather_card.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/weather_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Weather? weather;
  final TextEditingController controller = TextEditingController();
  bool isLoading = false;

  Future<void> _searchWeather() async {
    if (controller.text.isEmpty) return;

    setState(() => isLoading = true);
    try {
      final result = await WeatherServices().getWeather(controller.text);
      setState(() {
        weather = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching weather: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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

    final Color textColor = (weather == null)
        ? Colors.white
        : weather!.description.toLowerCase().contains("clear")
        ? Colors.black
        : Colors.white;

    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(gradient: gradient),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Search Weather",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40,),
            TextField(
              controller: controller,
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                hintText: "Enter city name",
                hintStyle: TextStyle(color: textColor.withOpacity(0.7)),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: _searchWeather,
                ),
              ),
              onSubmitted: (_) => _searchWeather(),
            ),
            const SizedBox(height: 20),
            if (isLoading)
              const CircularProgressIndicator()
            else if(weather == null)
              Text("No weather data available" , style: TextStyle(color: textColor))
            else
              WeatherCard(weather: weather!)
          ],
        ),
      ),
    );
  }
}
