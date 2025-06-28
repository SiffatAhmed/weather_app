import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:intl/intl.dart';

class SharedServices {
  Future<String?> getCity(double lat, double long) async {
    var placemark = await geocoding.placemarkFromCoordinates(lat, long);

    return placemark.first.locality;
  }

  Future<geocoding.Location> getLocation(String city) async {
    List<geocoding.Location> locations = await geocoding.locationFromAddress(city);
    return locations.first;
  }

  String formattedDate() {
    final now = DateTime.now();
    final formatter = DateFormat('MMMM d'); // e.g., "June 29"
    return 'Today - ${formatter.format(now)}';
  }
}
