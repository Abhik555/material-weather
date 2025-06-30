import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../bloc/weather/weather_bloc.dart';

class TemperatureDisplay extends StatefulWidget {
  const TemperatureDisplay({super.key});

  @override
  State<TemperatureDisplay> createState() => _TemperatureDisplayState();
}

class _TemperatureDisplayState extends State<TemperatureDisplay> {
  String unitTemperature = "C";
  String feelsLike = "-";
  String currentTemp = "-";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherSuccess) {
          unitTemperature = "C";
          feelsLike = state.data.currentApparentTemp.toString();
          currentTemp = state.data.currentTemp.toString();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$currentTemp\u00b0$unitTemperature',
                style: GoogleFonts.rye(fontSize: 75),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Feels like $feelsLike\u00b0$unitTemperature",
                    style: GoogleFonts.rye(fontSize: 23),
                  ),
                ],
              ),
            ],
          );
        } else {
          unitTemperature = "C";
          feelsLike = "-";
          currentTemp = "-";

          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Center(child: CircularProgressIndicator())],
          );
        }
      },
    );
  }
}
