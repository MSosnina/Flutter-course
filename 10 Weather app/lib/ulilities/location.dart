import 'package:geolocator/geolocator.dart';

class Location{
  double? latitude;
  double? longitude;

  Future<void> getCurrentLocation() async{
    try {
      LocationPermission permission;
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          return Future.error('Location Not Available');
        }
      }

      Position position = await Geolocator.getCurrentPosition().timeout(Duration(seconds: 15));
      latitude = position.latitude;
      longitude = position.longitude;
    } catch(e){
      throw 'Something goes wrong: $e';
    }
  }
 }