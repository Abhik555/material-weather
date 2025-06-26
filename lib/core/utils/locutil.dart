import 'package:location/location.dart';

import 'getit.dart';

Future<bool> checkLocation() async {
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  _serviceEnabled = await serviceLocator<Location>().serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await serviceLocator<Location>().requestService();
    if (!_serviceEnabled) {
      return false;
    }
  }

  _permissionGranted = await serviceLocator<Location>().hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await serviceLocator<Location>()
        .requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return false;
    }
  }

  return true;
}