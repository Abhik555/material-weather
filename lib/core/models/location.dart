class LocationInfo {
  bool isCurrent;
  String? name;
  double? latitude;
  double? longitude;

  LocationInfo({
    required this.isCurrent,
    this.name,
    this.latitude,
    this.longitude,
  });
}
