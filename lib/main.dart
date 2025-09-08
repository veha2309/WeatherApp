import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Force fullscreen immersive mode
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          primary: Colors.black,
          seedColor: Colors.blueAccent,
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.genosTextTheme(),
      ),

      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          primary: Colors.white,
          seedColor: Colors.grey.shade100,
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.genosTextTheme(),
      ),

      themeMode: ThemeMode.system, // 🔄 auto switch light/dark
      home: const MainScreen(),
    );
  }
}
