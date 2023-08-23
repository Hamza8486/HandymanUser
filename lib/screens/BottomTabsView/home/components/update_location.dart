import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_apps/Services/api_manager.dart';
import 'package:user_apps/res/colors.dart';
import 'package:user_apps/screens/BottomTabsView/home/controllers/home_controller.dart';
import 'package:user_apps/widgets/Colors/app_colors.dart';
import 'package:user_apps/widgets/Fonts/app_fonts.dart';
import 'package:user_apps/widgets/Loader/loader.dart';
import 'package:user_apps/widgets/app_button.dart';
import 'package:user_apps/widgets/app_text.dart';

import '../../../../widgets/SnackBar/snack_bar.dart';




class GetAddressView extends StatefulWidget {
  const GetAddressView({Key? key}) : super(key: key);



  @override
  State<GetAddressView> createState() => _GetAddressViewState();
}

class _GetAddressViewState extends State<GetAddressView> {
  var _selectedValue;
  final homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      maxChildSize: 0.4,
      minChildSize: 0.4,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: AppColor.WHITE_COLOR,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width*0.04,vertical: size.height*0.02),
          child: Column(

            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  height: 20,
                  child: Row(
                    children: [
                      Spacer(),
                      Container(
                        height: 5,
                        width: 50,
                        decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height*0.02,),
              AppText(
                title: "Изменить город",
                size: size.height * 0.02,
                fontFamily: Weights.regular,
                color: AppColors.blackColor,
                fontWeight: FontWeight.w800,
              ),
              SizedBox(height: size.height*0.02,),
              Expanded(
                // height: 400,
                child:SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'Выбрать город',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: AppColors.greyColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      DropdownButtonFormField(
                          decoration: InputDecoration(



                            contentPadding: EdgeInsets.symmetric(
                                vertical: size.height * 0.018,
                                horizontal: 10),



                          ),
                          value: _selectedValue,
                          style: TextStyle(color: AppColor.DARK_TEXT_COLOR,fontFamily: Weights.medium),
                          hint: Text(
                            'Выбрать город',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColor.DARK_TEXT_COLOR,
                              fontFamily: Weights.regular,
                            ),
                          ),
                          isExpanded: true,
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value!;
                            });
                          },
                          items:nameDataList(dataList: homeController.cityList)



                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(child: AppButton(
                      buttonRadius: BorderRadius.circular(10),
                      textSize: size.height*0.021,
                      buttonName: "Изменить город", buttonColor: AppColors.blueColor, textColor: AppColor.WHITE_COLOR, onTap: (){
                        if(validate()){
                          appLoader(context, AppColor.primaryColor);
                          ApiManger().changeAddressResponse(context: context,
                              address: _selectedValue.toString()
                          );
                        }
                  })),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<int>> nameDataList({var dataList}) {
    List<DropdownMenuItem<int>> outputList = [];
    for (int i = 0; i < dataList.length; i++) {
      outputList.add(DropdownMenuItem<int>(
          value: dataList[i].id,
          child: AppText(
            title: dataList[i].name,
            size: 16,
            color: AppColor.DARK_TEXT_COLOR,
            fontFamily: Weights.medium,
          )));
    }
    return outputList;
  }

  bool validate() {


    if (_selectedValue == null) {
      showErrorToast( 'Выбрать город');

      return false;
    }



    return true;
  }
}
