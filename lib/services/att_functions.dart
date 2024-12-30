
import 'dart:developer';

import 'package:app_set_id/app_set_id.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

import 'package:geolocator/geolocator.dart';
class AttFunctions {


  static Future<String?> getDeviceId() async {
   return await AppSetId().getIdentifier();
  }

  static bool calculateRadialDistance(GeoPoint currentPos, GeoPoint newLocation, double radius){
    final di = Geolocator.distanceBetween(currentPos.latitude,
        currentPos.longitude, newLocation.latitude, newLocation.longitude);
    log(":::::::::::$di");
    return  di <=
        radius;
  }

}