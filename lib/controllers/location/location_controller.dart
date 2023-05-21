// // ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously
// import 'package:flutter/widgets.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:google_maps_webservice/places.dart';

// class LocationController {
//   // static Future<String> _getApiKey() {
//   //   File apiKeyFile = File('lib/env/google_map/google_map_api.txt');
//   //   return apiKeyFile.readAsString();
//   // }

//   static Future<String> selectPlace(BuildContext context) async {
//     const apiKey = "db866104ff7f4dfabecdf50f2f0db403";
//     final prediction = await PlacesAutocomplete.show(
//       context: context,
//       apiKey: apiKey,
//       mode: Mode.overlay, // or Mode.fullscreen
//       language: 'en', // specify the language for results
//     );

//     if (prediction != null) {
//       GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: apiKey);
//       PlacesDetailsResponse details =
//           await places.getDetailsByPlaceId(prediction.placeId!);

//       if (details.status == 'OK') {
//         String address = details.result.formattedAddress!;
//         // Do something with the address
//         return address;
//       } else {
//         // Handle error response
//         throw Exception('No address found!');
//       }
//     } else {
//       // Handle canceled selection
//       throw Exception('No address found!');
//     }
//   }
// }

import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationController {
  late StreamSubscription<Position> streamSubscription;

  Future<Position> getLocation() async {
    bool serviceEnabled;

    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    // streamSubscription =
    //     Geolocator.getPositionStream().listen((Position position) {
    //   latitude = '${position.latitude}';
    //   longitude = '${position.longitude}';
    //   getAddressFromLatLang(position);
    // });
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<String> getAddressFromLatLang(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    return "${placemark[0].street}, ${placemark[0].postalCode}, ${placemark[0].locality}, ${placemark[0].administrativeArea}, ${placemark[0].country}";
  }
}





























//Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //Position position = await Geolocator.getLastKnownPosition()