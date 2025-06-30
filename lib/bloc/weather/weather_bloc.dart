import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:material_weather/core/models/location.dart';
import 'package:material_weather/core/models/weather.dart';
import 'package:material_weather/core/utils/locutil.dart';

import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart'
    hide PermissionStatus;
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/getit.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  LocationInfo info;

  WeatherBloc(this.info) : super(WeatherInitial()) {
    on<UpdateWeather>((event, emit) async {
      bool isAllowed = await checkLocation();
      emit(WeatherFirstLaunch(isPerms: isAllowed));
      await updateLogic(event, emit, info);
    });

    on<ChangeWeather>((event, emit) async {
      await changeLogic(event, emit, info);
    });

    on<SelectWeather>((event, emit) async {
      await selectLogic(event, emit, info);
    });

    on<RequestWeatherPermission>((event, emit) async {
      emit(WeatherLoading());
      bool isAllowed = await Permission.location.request().isGranted;
      return emit(WeatherFirstLaunch(isPerms: isAllowed));
    });
  }
}

Future<void> selectLogic(
  SelectWeather event,
  Emitter<WeatherState> emit,
  LocationInfo info,
) async {
  emit(WeatherLoading());
  try {
    info.latitude = event.latitude;
    info.longitude = event.longitude;
    info.name = event.name;
    info.isCurrent = false;

    serviceLocator.get<SharedPreferences>().setString("location", event.name);
    serviceLocator.get<SharedPreferences>().setDouble(
      "latitude",
      event.latitude,
    );
    serviceLocator.get<SharedPreferences>().setDouble(
      "longitude",
      event.longitude,
    );

    var data = await getData(event.name, event.latitude, event.longitude);
    return emit(WeatherSuccess(data: data));
  } catch (e) {
    return emit(WeatherFailure(error: "$e"));
  }
}

Future<void> changeLogic(
  ChangeWeather event,
  Emitter<WeatherState> emit,
  LocationInfo info,
) async {
  emit(WeatherLoading());
  try {
    var cityrequestURI = Uri.parse(
      "https://geocoding-api.open-meteo.com/v1/search?name=${event.name}&count=1",
    );
    final res = await http.get(cityrequestURI);
    final loc = jsonDecode(res.body);
    double latitude = loc["results"][0]["latitude"];
    double longitude = loc["results"][0]["longitude"];

    info.latitude = latitude;
    info.longitude = longitude;
    info.name = event.name;
    info.isCurrent = false;

    serviceLocator.get<SharedPreferences>().setString("location", event.name);
    serviceLocator.get<SharedPreferences>().setDouble("latitude", latitude);
    serviceLocator.get<SharedPreferences>().setDouble("longitude", longitude);

    var data = await getData(info.name!, info.latitude!, info.longitude!);
    return emit(WeatherSuccess(data: data));
  } catch (e) {
    print(e);
    return emit(WeatherFailure(error: "$e"));
  }
}

Future<void> updateLogic(
  UpdateWeather event,
  Emitter<WeatherState> emit,
  LocationInfo info,
) async {
  emit(WeatherLoading());
  try {
    if (info.isCurrent) {
      bool _serviceEnabled;
      PermissionStatus _permissionGranted;
      LocationData _locationData;

      _serviceEnabled = await serviceLocator<Location>().serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await serviceLocator<Location>().requestService();
        if (!_serviceEnabled) {
          return emit(
            WeatherFailure(error: "Location Service Failed to Start."),
          );
        }
      }

      _permissionGranted = await serviceLocator<Location>().hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await serviceLocator<Location>()
            .requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return emit(
            WeatherFailure(error: "Location Permission not Granted."),
          );
        }
      }

      _locationData = await serviceLocator<Location>().getLocation();

      var latitude = _locationData.latitude ?? 0;
      var longitude = _locationData.longitude ?? 0;

      var cityrequestURI = Uri.parse(
        "https://us1.api-bdc.net/data/reverse-geocode-client?latitude=$latitude&longitude=$longitude&localityLanguage=en",
      );
      final res = await http.get(cityrequestURI);

      String name = jsonDecode(res.body)["city"];

      info.name = name;
      info.longitude = longitude;
      info.latitude = latitude;

      serviceLocator.get<SharedPreferences>().setString("location", name);
      serviceLocator.get<SharedPreferences>().setDouble("latitude", latitude);
      serviceLocator.get<SharedPreferences>().setDouble("longitude", longitude);
    } else {
      var cityrequestURI = Uri.parse(
        "https://geocoding-api.open-meteo.com/v1/search?name=${info.name}&count=1",
      );
      final res = await http.get(cityrequestURI);
      final loc = jsonDecode(res.body);
      double latitude = loc["results"][0]["latitude"];
      double longitude = loc["results"][0]["longitude"];

      info.latitude = latitude;
      info.longitude = longitude;

      serviceLocator.get<SharedPreferences>().setString("location", info.name!);
      serviceLocator.get<SharedPreferences>().setDouble("latitude", latitude);
      serviceLocator.get<SharedPreferences>().setDouble("longitude", longitude);
    }
  } catch (e) {
    return emit(WeatherFailure(error: e.toString()));
  }

  try {
    var data = await getData(info.name!, info.latitude!, info.longitude!);
    return emit(WeatherSuccess(data: data));
  } catch (e) {
    return emit(WeatherFailure(error: "$e"));
  }
}

Future<WeatherData> getData(
  String name,
  double latitude,
  double longitude,
) async {
  var weatherRequestURI = Uri.parse(
    "https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&daily=temperature_2m_max,temperature_2m_min,uv_index_max,sunrise,sunset,apparent_temperature_max,apparent_temperature_min,wind_speed_10m_max,weather_code&hourly=temperature_2m,apparent_temperature&models=best_match&current=temperature_2m,precipitation,relative_humidity_2m,apparent_temperature,is_day,showers,snowfall,rain,cloud_cover,pressure_msl,surface_pressure,wind_gusts_10m,wind_speed_10m,wind_direction_10m,weather_code&timezone=auto",
  );

  final res = await http.get(weatherRequestURI);

  final data = jsonDecode(res.body);

  final w = WeatherData(
    currentTemp: data["current"]["temperature_2m"],
    currentApparentTemp: data["current"]["apparent_temperature"],
    currentHumidity: data["current"]["relative_humidity_2m"],
    currentPressure: data["current"]["surface_pressure"],
    currentPrecipitation: data["current"]["precipitation"],
    currentWindSpeed: data["current"]["wind_speed_10m"],
    daily: data["daily"],
    hourly: data["hourly"],
    location: name,
    isDay: data["current"]["is_day"] == 1,
    weathercode: data["current"]["weather_code"],
    unit: data["current_units"]["temperature_2m"],
  );

  return w;
}
