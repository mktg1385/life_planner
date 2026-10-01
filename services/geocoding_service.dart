import 'package:geocoding/geocoding.dart';

class GeocodingService {
  static Future<String?> getCityName(
    double latitude,
    double longitude,
  ) async {
    final placemarks =
        await placemarkFromCoordinates(
      latitude,
      longitude,
    );

    if (placemarks.isEmpty) {
      return null;
    }

    return placemarks.first.locality ??
        placemarks.first.subAdministrativeArea;
  }
}