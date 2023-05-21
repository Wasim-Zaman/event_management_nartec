import 'package:event_management/common/constants/app_colors.dart';
import 'package:event_management/common/widgets/buttons/primary_button_widget.dart';
import 'package:event_management/common/widgets/loading_widget/app_loading_widget.dart';
import 'package:event_management/controllers/location/location_controller.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  double lat = 0;
  double lng = 0;
  LocationController locationController = LocationController();
  final Set<Marker> markers = {};
  final Set<Circle> circles = {};
  Position? pos;
  bool isLoading = true;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      locationController.getLocation().then((value) {
        setState(() {
          pos = value;
          lat = pos!.latitude;
          lng = pos!.longitude;
          markers.add(
            Marker(
              markerId: const MarkerId("1"),
              position: LatLng(
                lat,
                lng,
              ),
              icon: BitmapDescriptor.defaultMarker,
              infoWindow: const InfoWindow(
                title: "Selected Location",
              ),
            ),
          );
          circles.clear();
          circles.add(
            Circle(
              circleId: const CircleId("1"),
              center: LatLng(
                lat,
                lng,
              ),
              radius: 100,
              fillColor: Colors.blue.withOpacity(0.2),
              strokeColor: Colors.blue,
              strokeWidth: 2,
            ),
          );
        });
      });
      isLoading = false;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Location"),
        backgroundColor: AppColors.primaryColor,
      ),
      body: isLoading
          ? const AppLoadingWidget()
          : Column(
              children: [
                Expanded(
                  child: GoogleMap(
                    buildingsEnabled: true,
                    compassEnabled: true,
                    mapToolbarEnabled: true,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    zoomControlsEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        lat,
                        lng,
                      ),
                      zoom: 14.4746,
                    ),
                    onMapCreated: (controller) {},
                    onTap: (latLng) {
                      setState(() {
                        lat = latLng.latitude;
                        lng = latLng.longitude;

                        markers.clear();
                        markers.add(
                          Marker(
                            markerId: const MarkerId("1"),
                            position: LatLng(
                              lat,
                              lng,
                            ),
                            icon: BitmapDescriptor.defaultMarker,
                            infoWindow: const InfoWindow(
                              title: "Selected Location",
                            ),
                          ),
                        );

                        // add the circle
                        circles.clear();
                        circles.add(
                          Circle(
                            circleId: const CircleId("1"),
                            center: LatLng(
                              lat,
                              lng,
                            ),
                            radius: 100,
                            fillColor: Colors.blue.withOpacity(0.2),
                            strokeColor: Colors.blue,
                            strokeWidth: 2,
                          ),
                        );
                      });
                    },
                    markers: markers,
                    circles: circles,
                    layoutDirection: TextDirection.ltr,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: PrimaryButtonWidget(
                      caption: "Select",
                      onPressed: () {
                        locationController
                            .getAddressFromLatLang(pos!)
                            .then((add) {
                          Navigator.pop(context, {
                            "lat": lat,
                            "lng": lng,
                            "address": add,
                          });
                        });
                      }),
                ),
              ],
            ),
    );
  }
}
