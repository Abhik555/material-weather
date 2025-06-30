import 'package:get_it/get_it.dart';
import 'package:location/location.dart';
import 'package:material_weather/core/models/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => prefs);

  if (prefs.getBool("firstLaunch") == null) {
    prefs.setBool("firstLaunch", true);
  }

  var state = await Permission.location.request();

  if(!state.isGranted){
    prefs.setBool("firstLaunch", true);
  }

  Location location = Location();
  serviceLocator.registerLazySingleton(() => location);
  LocationInfo info = LocationInfo(isCurrent: true);
  serviceLocator.registerLazySingleton(() => info);

  if (prefs.getString("location") == null) {
    info = LocationInfo(isCurrent: true, name: "Loading");
    prefs.setString("location", "Current");
    prefs.setDouble("latitude", 0);
    prefs.setDouble("longitude", 0);
  } else {
    info = LocationInfo(
      isCurrent: false,
      name: prefs.getString("location"),
      latitude: prefs.getDouble("latitude"),
      longitude: prefs.getDouble("longitude"),
    );
  }
}
