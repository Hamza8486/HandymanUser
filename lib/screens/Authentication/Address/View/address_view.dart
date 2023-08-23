// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:user_apps/screens/BottomTabsView/home/controllers/home_controller.dart';
import 'package:user_apps/widgets/Colors/app_colors.dart';
import 'package:user_apps/widgets/Fonts/app_fonts.dart';
import 'package:user_apps/widgets/app_button.dart';
import 'package:user_apps/widgets/app_field.dart';
import 'package:user_apps/widgets/app_text.dart';


// ignore: must_be_immutable
class AddAddress extends StatefulWidget {
   AddAddress({Key? key,this.address,this.lat,this.lng}) : super(key: key);


  var lat;
  var lng;
  var address;



  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {

  final homeController = Get.put(HomeController());
  late GoogleMapController _controller;
  String location = "";

  CameraPosition? cameraPosition;
  late Position currentLocation;
  var geoLocator = Geolocator();
  void locationPosition() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentLocation = position;
    LatLng latlatPostion = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPositions =
        CameraPosition(target: latlatPostion, zoom: 16);
    _controller.animateCamera(CameraUpdate.newCameraPosition(cameraPositions));
  }

  @override
  void initState() {
    locationPosition();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
          width: size.width,
          height: size.height,
          child: GoogleMap(
            zoomControlsEnabled: false,
            initialCameraPosition: const CameraPosition(
              target: LatLng(48.8561, 2.2930),
              zoom: 13.0,
            ),
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            mapToolbarEnabled: false,
            myLocationButtonEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
              locationPosition();
            },
            onCameraMove: (CameraPosition cameraPositiona) {
              cameraPosition = cameraPositiona;
            },
            onCameraIdle: () async {
              List<Placemark> placemarks = await placemarkFromCoordinates(
                  cameraPosition!.target.latitude,
                  cameraPosition!.target.longitude);
              setState(() {
                print(placemarks);
                print(cameraPosition!.target.latitude);
                print(cameraPosition!.target.longitude);

                location = placemarks.first.administrativeArea.toString() +
                    ", " +
                    placemarks.first.street.toString() +
                    ", " +
                    placemarks.first.subLocality.toString();

                homeController.addressController.text = location;
                homeController.lat = cameraPosition!.target.latitude;
                homeController.lng = cameraPosition!.target.longitude;
              });
            },
          ),
        ),
        Positioned(
            bottom: 0,
            child: Container(
              width: size.width,
              decoration: BoxDecoration(
                  color: AppColor.WHITE_COLOR,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.02,
                      horizontal: size.width * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                          title: "Select Address",
                          color: AppColor.DARK_TEXT_COLOR,
                          fontFamily: Weights.medium),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      AppTextField(
                        borderColor: AppColor.primaryColor,
                        controller: homeController.addressController,
                        borderRadius: BorderRadius.circular(15),
                        maxLines: 1,

                        hint: "Address",
                        prefixIcon: Icon(
                          Icons.pin_drop_rounded,
                          color: AppColor.primaryColor,
                        ),
                        isborderline: true,
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      AppButton(
                          buttonRadius: BorderRadius.circular(10),
                          textSize: size.height * 0.02,
                          buttonWidth: size.width,
                          buttonHeight: size.height * 0.063,
                          buttonName: "Confirm Location",
                          buttonColor: AppColor.primaryColor,
                          textColor: AppColor.WHITE_COLOR,
                          onTap: () {
Get.back();
                          })
                    ],
                  )),
            )),
        Positioned(
            top: size.height * 0.1,
            right: size.width * 0.03,
            child: InkWell(
                onTap: () {
                  locationPosition();
                },
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: AppColor.WHITE_COLOR.withOpacity(0.9),
                  child: Icon(
                    Icons.location_searching,
                    color: AppColor.BLACK_COLOR,
                  ),
                ))),
        Center(
          child: InkWell(
              onTap: () {
                location;
                print(location);
              },
              child: Image.asset("assets/images/pin.png",
                  width: 50, color: AppColor.primaryColor)),
        ),
      ],
    ));
  }
}
