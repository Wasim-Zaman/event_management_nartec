import 'package:event_management/common/widgets/loading_widget/app_loading_widget.dart';
import 'package:event_management/controllers/eaglesClub/eagles_club_controller.dart';
import 'package:event_management/controllers/location/location_controller.dart';
import 'package:event_management/screens/profile/components/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EaglesClubScreen extends StatefulWidget {
  const EaglesClubScreen({Key? key}) : super(key: key);

  @override
  State<EaglesClubScreen> createState() => _EaglesClubScreenState();
}

class _EaglesClubScreenState extends State<EaglesClubScreen> {
  LocationController locationController = LocationController();
  double lat = 0;
  double lng = 0;
  final Set<Marker> markers = {};
  final Set<Circle> circles = {};
  Position? pos;
  bool isLoading = true;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      EaglesClubController.getLatLong().then((listOfData) {
        for (var model in listOfData) {
          setState(() {
            markers.add(
              Marker(
                markerId: MarkerId(DateTime.now().toString()),
                position: LatLng(
                  double.parse(model.lattitiude.toString()),
                  double.parse(model.longitude.toString()),
                ),
                icon: BitmapDescriptor.defaultMarker,
              ),
            );
            circles.add(
              Circle(
                circleId: CircleId(DateTime.now().toString()),
                center: LatLng(
                  double.parse(model.lattitiude.toString()),
                  double.parse(model.longitude.toString()),
                ),
                // normal raduis
                radius: 500,
                fillColor: Colors.blue.withOpacity(0.1),
                strokeColor: Colors.blue,
                strokeWidth: 1,
              ),
            );
          });
        }
      });
      locationController.getLocation().then((value) {
        setState(() {
          pos = value;
          lat = pos!.latitude;
          lng = pos!.longitude;
        });
      });
      isLoading = false;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Eagles Club'),
      ),
      body: isLoading
          ? const AppLoadingWidget()
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(lat, lng),
                // zoom out little bit
                zoom: 10,
              ),
              markers: markers,
              circles: circles,
            ),
    );
  }
}
