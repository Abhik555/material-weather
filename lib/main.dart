import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_weather/core/routes/routes.dart';
import 'package:material_weather/core/utils/getit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  // Permission.location.request();
  runApp(const MaterialWeather());
}

class MaterialWeather extends StatefulWidget {
  const MaterialWeather({super.key});

  @override
  State<MaterialWeather> createState() => _MaterialWeatherState();
}

class _MaterialWeatherState extends State<MaterialWeather> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: routerConfig,
      title: "Material Weather",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ThemeData.light().colorScheme,
        fontFamily: GoogleFonts.delius().fontFamily,
      ),
      darkTheme: ThemeData(
        colorScheme: ThemeData.dark().colorScheme,
        fontFamily: GoogleFonts.delius().fontFamily,
      ),
      themeMode: ThemeMode.dark,
    );
  }
}
