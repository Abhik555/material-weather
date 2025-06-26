import 'package:flutter/material.dart';
import 'package:material_weather/core/ui/widgets/selector_widget.dart';

class LocationChangeScreen extends StatefulWidget {
  const LocationChangeScreen({super.key});

  @override
  State<LocationChangeScreen> createState() => _LocationChangeScreenState();
}

class _LocationChangeScreenState extends State<LocationChangeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 27, 27, 27),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Search City",
          style: Theme.of(
            context,
          ).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: CitySelector(),
    );
  }
}
