import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_weather/core/ui/widgets/daytile/daytile.dart';

import '../../bloc/weather/weather_bloc.dart';

class SevenDaysForecastScreen extends StatefulWidget {
  const SevenDaysForecastScreen({super.key});

  @override
  State<SevenDaysForecastScreen> createState() =>
      _SevenDaysForecastScreenState();
}

class _SevenDaysForecastScreenState extends State<SevenDaysForecastScreen> {
  @override
  Widget build(BuildContext context) {
    var state = context.watch<WeatherBloc>().state;

    if (state is! WeatherSuccess) {
      return CircularProgressIndicator();
    } else {
      return Scaffold(
        backgroundColor: Color.fromARGB(255, 27, 27, 27),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "7 Day Forecast",
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: state.data.daily!["time"].length,
          itemBuilder: (BuildContext c, int index) {
            return DayTile(
              daydate: state.data.daily!["time"][index],
              max: state.data.daily!["temperature_2m_max"][index],
              min: state.data.daily!["temperature_2m_min"][index],
              weathercode: state.data.daily!["weather_code"][index],
              unit: state.data.unit!,
            );
          },
        ),
      );
    }
  }
}
