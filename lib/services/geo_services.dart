import 'package:flutter/Material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';


class GeoService {
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showDialog(
        context: Get.context!,
        builder: (context) {
          return
            AlertDialog(
              title: Text('Enable Location?'),
              content: Text('Allow Closemart to access your location while you’re using the app'),
              actions: [
                TextButton(onPressed: ()async{
                  final res = await Geolocator.openLocationSettings();
                  if (!res) {
                    Geolocator.openAppSettings();
                  }
                  Get.back();
                }, child:
                Text('Yes'))
              ],
            );
        },
      );
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showDialog(
          context: Get.context!,
          builder: (context) {
            return
              AlertDialog(
                title: Text('Enable Location?'),
                content: Text('Allow Closemart to access your location while you’re using the app'),
                actions: [
                  TextButton(onPressed: ()async{
                    final res = await Geolocator.openLocationSettings();
                    if (!res) {
                      Geolocator.openAppSettings();
                    }
                    Get.back();
                  }, child:
                  Text('Yes'))
                ],
              );
          },
        );
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
