import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/home/home_page.dart';
import 'package:weather_app/more/more_page.dart';
import 'package:weather_app/search/search_page.dart';
import 'package:weather_app/services/weather_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future<Map<String, dynamic>>? _initFuture;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _initFuture = _detectCityAndWeather();
  }

  Future<Position> _determinePosition() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) throw "Location services are disabled";

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw "Location permissions are denied";
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw "Location permissions are permanently denied";
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<Map<String, dynamic>> _detectCityAndWeather() async {
    final position = await _determinePosition();
    final place =
    await placemarkFromCoordinates(position.latitude, position.longitude);

    final city = place.isNotEmpty ? place[0].locality : null;
    final locality = place.isNotEmpty ? place[0].subLocality : null;

    final weather =
    city != null ? await WeatherServices().getWeather(city) : null;

    return {
      "city": city,
      "locality": locality,
      "lat": position.latitude,
      "long": position.longitude,
      "weather": weather,
    };
  }

  void _refreshData() {
    setState(() {
      _initFuture = _detectCityAndWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
        icon: const Icon(Icons.refresh),
        onPressed: _refreshData,
      ),
      body: _initFuture == null
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<Map<String, dynamic>>(
        future: _initFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            final data = snapshot.data!;

            /// 👇 yahan pages ka list banate hain
            final List<Widget> pages = [
              HomeBody(
                weather: data["weather"],
                city: data["city"],
                locality: data["locality"],
                lat: data["lat"],
                long: data["long"],
              ),
              SearchPage(),
              MorePage(),
            ];

            return pages[_selectedIndex];
          } else {
            return const Center(child: Text("No data"));
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz_sharp), label: "More"),
        ],
      ),
    );
  }
}
