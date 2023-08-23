// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:user_apps/Services/api_manager.dart';
import 'package:user_apps/screens/BottomTabsView/home/controllers/home_controller.dart';
import 'package:user_apps/widgets/Colors/app_colors.dart';
import 'package:user_apps/widgets/Fonts/app_fonts.dart';
import 'package:user_apps/widgets/Loader/loader.dart';
import 'package:user_apps/widgets/app_button.dart';
import 'package:user_apps/widgets/app_field.dart';
import 'package:user_apps/widgets/app_text.dart';

import '../../../../widgets/SnackBar/snack_bar.dart';


// ignore: must_be_immutable
class UpdateAddress extends StatefulWidget {
  const UpdateAddress({Key? key}) : super(key: key);





  @override
  State<UpdateAddress> createState() => _UpdateAddressState();
}

class _UpdateAddressState extends State<UpdateAddress> {

  final homeController = Get.put(HomeController());

  final addressController = TextEditingController();
  final cityController = TextEditingController();
  late GoogleMapController _controller;
  String location = "";
  var lat;
  var lng;


  String? _selectedValue;
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
                myLocationEnabled: false,
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

                    addressController.text = location;
                   lat = cameraPosition!.target.latitude;
                    lng = cameraPosition!.target.longitude;
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
                        children: [
                          AppText(
                              title: "Select Address",
                              color: AppColor.DARK_TEXT_COLOR,
                              fontFamily: Weights.medium),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          DropdownButtonFormField(
                              decoration: InputDecoration(

                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(width: 1, color: AppColor.primaryColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(width: 1,color: AppColor.primaryColor),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: size.height * 0.018,
                                    horizontal: 10),



                              ),
                              value: _selectedValue,
                              hint: Text(
                                'Select City',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColor.DARK_TEXT_COLOR,
                                  fontFamily: Weights.regular,
                                ),
                              ),
                              isExpanded: true,
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedValue = value!;
                                });
                              },
                              items:nameDataList(dataList: homeController.cityList)



                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          AppTextField(
                            borderColor: AppColor.primaryColor,
                            controller: addressController,
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
                              buttonHeight: size.height * 0.056,
                              buttonName: "Update Location",
                              buttonColor: AppColor.primaryColor,
                              textColor: AppColor.WHITE_COLOR,
                              onTap: () {
                              if(validate()){
                                appLoader(context, AppColor.primaryColor);



                                ApiManger().changeAddressResponse(context: context,


                                );
                              }
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
                        color: AppColor.primaryColor,
                      ),
                    ))),
            Positioned(
                top: size.height * 0.1,
                left: size.width * 0.03,
                child: InkWell(
                    onTap: () {
                     Get.back();
                    },
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(color: AppColor.BLACK_COLOR),
                      borderRadius: BorderRadius.circular(6)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12,right: 4,top: 6,bottom: 6),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ),
                    )
                )

            ),
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
  List<DropdownMenuItem<String>> nameDataList({var dataList}){
    List<DropdownMenuItem<String>> outputList=[] ;
    for(int i=0; i<dataList.length; i ++){
      outputList.add( DropdownMenuItem<String>(
          value: dataList[i].name,
          child:AppText(title:  dataList[i].name,
            size: 16,
            color: AppColor.DARK_TEXT_COLOR,
            fontFamily : Weights.regular,
          )
      ));

    }
    return   outputList;
  }

  bool validate() {

    if (_selectedValue == null) {
      showErrorToast( 'Select City');

      return false;
    }

    if (addressController.text.isEmpty) {
      showErrorToast( 'Select address');

      return false;
    }
    return true;
  }
}
