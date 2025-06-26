class WeatherData {
  final int? weathercode;
  final double? currentTemp;
  final double? currentApparentTemp;
  final double? currentWindSpeed;
  final int? currentHumidity;
  final double? currentPressure;
  final double? currentPrecipitation;
  final double? timezone;
  final String? location;
  final bool? isDay;
  final String? unit;

  final Map<String, dynamic>? daily;
  final Map<String, dynamic>? hourly;

  WeatherData({
    this.weathercode,
    this.currentTemp,
    this.currentApparentTemp,
    this.currentWindSpeed,
    this.currentHumidity,
    this.currentPressure,
    this.currentPrecipitation,
    this.timezone,
    this.daily,
    this.hourly,
    this.location,
    this.isDay,
    this.unit,
  });
}

final ICONMAP = {
  0: 'assets/icons/clear-day.json',
  1: 'assets/icons/mostly-clear-day.json',
  2: 'assets/icons/partly-cloudy-day.json',
  3: 'assets/icons/overcast.json',
  45: 'assets/icons/fog.json',
  48: 'assets/icons/fog.json',
  51: 'assets/icons/drizzle.json',
  53: 'assets/icons/overcast-drizzle.json',
  55: 'assets/icons/extreme-day-drizzle.json',
  80: 'assets/icons/rain.json',
  81: 'assets/icons/overcast-rain.json',
  82: 'assets/icons/extreme-rain.json',
  61: 'assets/icons/rain.json',
  63: 'assets/icons/overcast-rain.json',
  65: 'assets/icons/extreme-rain.json',
  56: 'assets/icons/overcast-sleet.json',
  57: 'assets/icons/extreme-sleet.json',
  66: 'assets/icons/overcast-sleet.json',
  67: 'assets/icons/extreme-sleet.json',
  71: 'assets/icons/snow.json',
  73: 'assets/icons/extreme-snow.json',
  75: 'assets/icons/extreme-snow.json',
  77: 'assets/icons/snowflake.json',
  85: 'assets/icons/snow.json',
  86: 'assets/icons/extreme-snow.json',
  95: 'assets/icons/thunderstorms-extreme.json',
  96: 'assets/icons/thunderstorms-extreme-snow.json',
  99: 'assets/icons/thunderstorms-extreme-snow.json',
};
