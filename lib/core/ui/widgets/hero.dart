import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:material_weather/core/models/weather.dart';

import '../../../bloc/weather/weather_bloc.dart';

class HeroWidget extends StatefulWidget {
  const HeroWidget({super.key});

  @override
  State<HeroWidget> createState() => _HeroWidgetState();
}

class _HeroWidgetState extends State<HeroWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if(state is WeatherFirstLaunch){
          return Container();
        }

        if (state is WeatherFailure) {
          return Text(state.error);
        }

        if (state is! WeatherSuccess) {
          return Column(children: [Text("Loading")]);
        }

        return SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Lottie.asset(
                ICONMAP[state.data.weathercode]!,
                height: MediaQuery.of(context).size.height * 0.28,
                width: 250,
              ),
              Text(
                "${state.data.currentTemp}${state.data.unit}",
                style: GoogleFonts.delius().copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 74,
                ),
              ),
              Text(
                "Feels like ${state.data.currentApparentTemp}${state.data.unit}",
                style: GoogleFonts.delius().copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
