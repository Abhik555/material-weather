part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}

final class UpdateWeather extends WeatherEvent {}

final class ChangeWeather extends WeatherEvent {
  final String name;

  ChangeWeather({required this.name});
}

final class RequestWeatherPermission extends WeatherEvent {}

final class SelectWeather extends WeatherEvent {
  final String name;
  final double latitude;
  final double longitude;

  SelectWeather({
    required this.name,
    required this.latitude,
    required this.longitude,
  });
}
