import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:material_weather/core/models/location.dart';
import 'package:material_weather/core/ui/widgets/forecast_button.dart';
import 'package:material_weather/core/ui/widgets/hero.dart';
import 'package:material_weather/core/ui/widgets/infotile/info_item.dart';
import 'package:material_weather/core/ui/widgets/infotile/info_tile.dart';
import 'package:material_weather/core/utils/getit.dart';
import '../../bloc/weather/weather_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<WeatherBloc>().add(UpdateWeather());
  }

  @override
  Widget build(BuildContext context) {
    context.read<WeatherBloc>().add(UpdateWeather());
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 27, 27, 27),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            serviceLocator.get<LocationInfo>().isCurrent = true;
            context.read<WeatherBloc>().add(UpdateWeather());
          },
          icon: Icon(Clarity.map_marker_line),
        ),
        title: GestureDetector(
          onTap: () {
            context.pushNamed("change");
          },
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherFirstLaunch) {
                return Text(
                  "Loading",
                  style: GoogleFonts.delius().copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }
              if (state is WeatherLoading) {
                return Text(
                  "Loading",
                  style: GoogleFonts.delius().copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    serviceLocator.get<LocationInfo>().name ?? "",
                    style: GoogleFonts.delius().copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Icon(Icons.keyboard_arrow_down),
                ],
              );
            },
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.read<WeatherBloc>().add(UpdateWeather());
            },
            icon: Icon(Clarity.refresh_line),
          ),
        ],
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                HeroWidget(),
                const SizedBox(height: 30),
                BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is! WeatherSuccess) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return InfoWidget(
                      items: [
                        InfoItem(
                          title: "Wind",
                          data:
                              "${state.data.currentWindSpeed.toString()} Km/h",
                          asset: "assets/icons/wind.json",
                          size: MediaQuery.of(context).size.width * 0.16,
                        ),
                        InfoItem(
                          title: "Humidity",
                          data: "${state.data.currentHumidity.toString()}%",
                          asset: "assets/icons/humidity.json",
                          size: MediaQuery.of(context).size.width * 0.16,
                        ),
                        InfoItem(
                          title: "Rain",
                          data:
                              "${state.data.currentPrecipitation.toString()}%",
                          asset: "assets/icons/raindrops.json",
                          size: MediaQuery.of(context).size.width * 0.16,
                        ),
                      ],
                    );
                  },
                ),
                BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (c, state) {
                    if (state is WeatherSuccess) {
                      return ForecastButton(
                        onClick: () {
                          context.push("/forecast");
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
