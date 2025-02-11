import 'package:geocoding/geocoding.dart' as geocoding;

class SharedServices {
  Future<String?> getCity(double lat, double long) async {
    var placemark = await geocoding.placemarkFromCoordinates(lat, long);

    return placemark.first.locality;
  }

  Future<geocoding.Location> getLocation(String city) async {
    List<geocoding.Location> locations = await geocoding.locationFromAddress(city);
    return locations.first;
  }
}
