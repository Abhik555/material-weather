part of 'weather_bloc.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class WeatherFirstLaunch extends WeatherState {
  final bool isPerms;
  WeatherFirstLaunch({required this.isPerms});
}

final class WeatherLoading extends WeatherState {}

final class WeatherSuccess extends WeatherState {
  final WeatherData data;
  WeatherSuccess({required this.data});
}

final class WeatherFailure extends WeatherState {
  final String error;
  WeatherFailure({required this.error});
}
