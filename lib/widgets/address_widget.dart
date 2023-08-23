// ignore_for_file: prefer_const_constructors, avoid_print, must_be_immutable

import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:user_apps/Services/helper_function.dart';
import 'package:user_apps/res/colors.dart';
import 'package:user_apps/screens/Authentication/SignIn/View/sign_view.dart';
import 'package:user_apps/screens/BottomTabsView/home/controllers/home_controller.dart';
import 'package:user_apps/screens/BottomTabsView/home/controllers/sub_controller.dart';
import 'package:user_apps/screens/BottomTabsView/post_a_job/controllers/post_a_job_controller.dart';
import 'package:user_apps/screens/BottomTabsView/support_section/controllers/support_section_controller.dart';
import 'package:user_apps/screens/my_requests/controllers/my_request_controller.dart';
import 'package:user_apps/screens/provider_detail/controller/provider_detail_controller.dart';
import 'package:user_apps/screens/provider_list/controller/provider_list_controller.dart';
import 'package:user_apps/screens/review/controller/review_controller.dart';
import 'package:user_apps/widgets/Colors/app_colors.dart';
import 'package:user_apps/widgets/Fonts/app_fonts.dart';
import 'package:user_apps/widgets/app_dimensions.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../screens/BottomTabsView/my_requests/Controller/controller.dart';



class AddressWidget extends StatefulWidget {
  AddressWidget({
    Key? key,this.text1,this.text,
  }) : super(key: key);
  var text;
  var text1;

  @override
  State<AddressWidget> createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  final dropOffFocus = FocusNode();
  var authController = Get.put(PostAJobController());

  String _sessionToken2 = '12345';
  var uuid = Uuid();
  bool isListViewOpenDropOf = false;
  List<dynamic> placesListDropOf = [];
  Timer? _debounce;

  Future<LatLng> getLatLngFromAddress(var address) async {
    GeoData data = await Geocoder2.getDataFromAddress(
        address: address, googleMapApiKey: AppColor.apiKey);
    return LatLng(data.latitude, data.longitude);
  }






  void onChangeDropOff() {
    if (_sessionToken2 == null || _sessionToken2.isEmpty) {
      setState(() {
        _sessionToken2 = uuid.v4();
      });
    }
    if (authController.addressController.text.isNotEmpty) {
      setState(() {
        getSuggessionDrop(authController.addressController.text);
      });
    }
  }


  void getSuggessionDrop(String input) async {
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=${AppColor.apiKey}&sessiontoken=$_sessionToken2';

    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();
    debugPrint('data:::::::::${data}');
    if (response.statusCode == 200) {
      setState(() {
        placesListDropOf = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception();
    }
  }

  @override
  void initState() {
    authController.addressController.addListener(() {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 00), () {
        onChangeDropOff();
      });
    });
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColor.BLACK_COLOR.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: AppColors.greyColor.withOpacity(0.2),
                blurRadius: 3.0,
                offset: const Offset(5.0, 0.0),
              ),
              BoxShadow(
                color: AppColors.greyColor.withOpacity(0.2),
                blurRadius: 3.0,
                offset: const Offset(0.0, 5.0),
              ),
            ],
          ),
          child: TextFormField(
            cursorColor: AppColor.DARK_GREY_COLOR,


            controller: authController.addressController,
            onFieldSubmitted: (val) {
              FocusScope.of(context)
                  .requestFocus(this.dropOffFocus);
            },
            onChanged: (value) {
              setState(() {
                if (authController.addressController
                    .text.isNotEmpty) {
                  isListViewOpenDropOf = true;
                } else {
                  isListViewOpenDropOf = false;
                }
              });
            },
            style: TextStyle(
                fontFamily: Weights.medium,
                fontSize: AppDimensions.FONT_SIZE_14,
                color: AppColor.DARK_TEXT_COLOR),

            decoration: InputDecoration(

              hintText: 'Улица, дом',
              contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
              hintStyle: TextStyle(
                color: AppColor.DARK_TEXT_COLOR.withOpacity(0.7),
                fontSize: AppDimensions.FONT_SIZE_13,
                fontFamily: Weights.regular,
              ),

              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
            keyboardType: TextInputType.streetAddress,
          ),
        ),



                    isListViewOpenDropOf
                ? Padding(
              padding:
              const EdgeInsets.only(top: 0.0),
              child: Container(
                height: Get.height*0.3,
                color: Colors.transparent,
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,

                    itemCount:
                    placesListDropOf.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () async {
                          LatLng latLng =
                          await getLatLngFromAddress(
                              placesListDropOf[
                              index][
                              'description']);
                          debugPrint("Lat Lng");
                          debugPrint(
                            latLng.latitude.toString(),
                          );
                          print(
                            latLng.longitude,
                          );

                          setState(() {
                            // authController.lat = latLng.latitude.toString();
                            // authController.long = latLng.longitude.toString();
                            // debugPrint(authController.lat);
                            // debugPrint( authController.long );
                            authController.addressController
                                .text =
                            placesListDropOf[
                            index]
                            ['description'];
                            isListViewOpenDropOf =
                            false;
                            FocusScope.of(context)
                                .unfocus();
                          });
                        },
                        title: Row(

                          children: [
                           CircleAvatar(
                              radius: 13,
                              backgroundColor: AppColor.primaryColor,
                              child: Icon(
                                Icons.location_on_rounded,
                                color: AppColor.WHITE_COLOR,
                                size: Get.height * 0.018,
                              ),
                            ),
                            SizedBox(width: Get.width*0.02,),
                            Expanded(
                              child: Text(
                                placesListDropOf[index]
                                ['description'],
                                style: TextStyle(
                                    color: AppColor
                                        .primaryColor,
                                fontSize: AppDimensions.FONT_SIZE_13,fontFamily: Weights.medium
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            )
                : Container(),

      ],
    );
  }
}

Future<bool> showExitPopup(context ,index ,onChange) async{
  if(index==0){
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)
              ),
              height: Get.height*0.12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Do you want to close?",style: TextStyle(color: AppColor.primaryColor,
                      fontFamily: Weights.medium
                  ),),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                            ),
                            child: const Text("No", style: TextStyle(color: Colors.black)),
                          )),
                      const SizedBox(width: 15),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: ()async{
                           Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              primary: AppColor.primaryColor),

                          child:  Text("Yes",style: TextStyle(color: AppColor.WHITE_COLOR),),
                        ),
                      ),


                    ],
                  )
                ],
              ),
            ),
          );
        });}
  else{
    onChange(0);
    return false;
  }
}