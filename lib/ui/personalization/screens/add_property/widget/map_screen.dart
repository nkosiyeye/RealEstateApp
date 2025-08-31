import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart';
import 'package:real_estate_app/ui/personalization/controller/add_property_controller.dart';

import '../../../../../common/widgets/appbar/appbar.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key});

  @override
  State<StatefulWidget> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  final addController = AddPropertyController.instance;
  final locationController = loc.Location();
  static const googlePlex = LatLng(37.4223, -122.0949);

  LatLng? currentPosition;
  String? street, city, state, country, postalCode;
  GoogleMapController? mapController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await fetchLocationUpdates());
  }

  Future<void> _performReverseGeocoding(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        setState(() {
          postalCode = placemarks.first.postalCode;
          street = placemarks.first.street;
          city = placemarks.first.locality;
          state = placemarks.first.administrativeArea;
          country = placemarks.first.country;
        });
      }
    } catch (e) {
      print('Error in reverse geocoding: $e');
    }
  }

  void _onMarkerTapped(LatLng tappedPosition) {
    setState(() {
      currentPosition = tappedPosition;
    });
    _performReverseGeocoding(tappedPosition);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: TAppBar(
      showBackArrow: true,
      title: (street != null && city != null && state != null && country != null)
          ? Text('$street, $city, $country')
          : const Text('Select Address'),
    ),
    body: Stack(
      children: [
        currentPosition == null
            ? const Center(child: CircularProgressIndicator())
            : GoogleMap(
          initialCameraPosition: const CameraPosition(target: googlePlex, zoom: 13),
          markers: {
            Marker(
              markerId: const MarkerId('Current Location'),
              icon: BitmapDescriptor.defaultMarker,
              position: currentPosition!,
              onTap: () {
                _onMarkerTapped(currentPosition!);
              },
              draggable: true,
              onDragEnd: (newPosition) {
                _onMarkerTapped(newPosition);
              },
            )
          },
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
          },
          onTap: (LatLng tappedPosition) {
            _onMarkerTapped(tappedPosition);
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton.extended(
            onPressed: () {
              if (street != null && city != null && state != null && country != null) {
                addController.country.text = country!;
                addController.city.text = city!;
                addController.region.text = state!;
                addController.address.text = '$street,$state, $city, $country';
                addController.longitude.value = currentPosition!.longitude.toString();
                addController.latitude.value = currentPosition!.latitude.toString();
                Get.back();
              } else {
                print('Address details are not available yet.');
              }
            },
            label: const Text('Next'),
            icon: const Icon(Iconsax.arrow_right_15),
          ),
        ),
      ],
    ),
  );

  Future<void> fetchLocationUpdates() async {
    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;

    serviceEnabled = await locationController.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await locationController.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await locationController.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await locationController.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    locationController.onLocationChanged.listen((currentLocation) {
      if (currentLocation.latitude != null && currentLocation.longitude != null) {
        setState(() {
          currentPosition = LatLng(currentLocation.latitude!, currentLocation.longitude!);
        });
        _performReverseGeocoding(currentPosition!);

        // Animate camera to current location
        mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(currentPosition!, 15),
        );
      }
    });
  }
}