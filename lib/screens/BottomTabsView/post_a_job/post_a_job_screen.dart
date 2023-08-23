
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:user_apps/Services/api_manager.dart';
import 'package:user_apps/Services/helper_function.dart';
import 'package:user_apps/res/colors.dart';
import 'package:user_apps/screens/Authentication/SignIn/View/sign_view.dart';
import 'package:user_apps/screens/BottomTabsView/home/controllers/home_controller.dart';
import 'package:user_apps/screens/BottomTabsView/profile/controllers/profile_controller.dart';
import 'package:user_apps/screens/provider_list/controller/provider_list_controller.dart';
import 'package:user_apps/widgets/AppDimensions/app_dimensions.dart';
import 'package:user_apps/widgets/Colors/app_colors.dart';
import 'package:user_apps/widgets/Fonts/app_fonts.dart';
import 'package:user_apps/widgets/Loader/loader.dart';
import 'package:user_apps/widgets/SnackBar/snack_bar.dart';
import 'package:user_apps/widgets/address_widget.dart';
import 'package:user_apps/widgets/app_dimensions.dart';
import 'package:user_apps/widgets/app_text.dart';

import 'components/attach_button.dart';
import 'controllers/post_a_job_controller.dart';

class PostJobScreen extends StatefulWidget {
   PostJobScreen({Key? key,this.data}) : super(key: key);
  var data;
  var data1;
  var data2;

  @override
  State<PostJobScreen> createState() => _PostJobScreenState();
}

class _PostJobScreenState extends State<PostJobScreen> {
  final  postAJobController = Get.put(PostAJobController());
  final  homeController = Get.put(HomeController());
  final providerController = Get.put(ProviderListController());

  var aboutController = TextEditingController();
  var _selectedValue;
  List<String> cityValue = [
    "Lahore",
    "Islamabad",
    "Sargodha",
    "Faisalabad",
  ];

  String? countryValue;
  File ?file;
  var userId = "".obs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HelperFunctions.getFromPreference("id").then(
            (value){
          userId.value = value;

        });
    postAJobController.addressController.text = homeController.profileMOdel?.address??"";
  }


  @override
  Widget build(BuildContext context) {
    var size = Get.size;
    final double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async{
        return
          providerController.valueId.value == "true"?true :
          false;
      },
      child: Scaffold(
        backgroundColor: AppColors.backColor,
        body: Column(
          children: [
            Material(
              color: AppColor.WHITE_COLOR,
              elevation: 1,
              child: SizedBox(
                width: size.width,
                height: size.height / 8.5 ,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.025,
                          vertical: size.height * 0.003 ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Obx(
                             () {
                              return Row(
                                children: [
                                  providerController.valueId.value == "true"?
                                  GestureDetector(
                                    onTap: () {

                                      Get.back();
                                    },
                                    child: Container(
                                      height: 35.0,
                                      width: 35.0,
                                      margin: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: AppColor.primaryColor),

                                      ),
                                      child: const Center(
                                        child: Icon(Icons.arrow_back, color:AppColors.blueColor, size: 24.0),
                                      ),
                                    ),
                                  ):Container(),
                                  SizedBox(width: Get.width*0.02,),
                                  AppText(
                                      title: "Создать заявку",
                                    size: Get.height * 0.018,
                                    overFlow: TextOverflow.ellipsis,
                                    color: AppColor.DARK_TEXT_COLOR,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,),
                                ],
                              );
                            }
                          ),

                          homeController.profileMOdel?.id == null?GestureDetector(
                            onTap: (){
                              Get.offAll(SignInView());
                            },
                            child: Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 10),
                              child: AppText(
                                  title: "Login",
                                  size: size.height * 0.02,
                                  overFlow: TextOverflow.ellipsis,
                                  color: AppColor.primaryColor,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,),
                            ),
                          )
              :

                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 10),
                            child: GestureDetector(
                              onTap: (){
                                if(validate()){
                                  appLoader(context, AppColor.primaryColor);
                                  print(homeController.providerId.value);
                                  print("This is SubId ${homeController.subId.value}");
                                  ApiManger().postJobAll(
                                    provider: homeController.providerId.value,
                                    sub: homeController.subId.value,

                                    context: context,


                                  );
                                }
                              },
                              child: AppText(
                                  title: "Опубликовать",
                                  size: size.height * 0.02,
                                  overFlow: TextOverflow.ellipsis,
                                  color: AppColor.primaryColor,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.04,
                      vertical: size.height * 0.008 ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [


                      SizedBox(height: Get.height*0.02),
                      AppText(
                          title: "Опишите задание и получите предложения от специалистов",
                          size: size.height * 0.019,
                          maxLines: 2,
                          overFlow: TextOverflow.ellipsis,
                          color: AppColor.DARK_TEXT_COLOR,

                          fontFamily: Weights.medium),
                      SizedBox(height: Get.height*0.015),
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
                          maxLines: 3,
                          style: TextStyle(
                              fontFamily: Weights.medium,
                              fontSize: AppDimensions.FONT_SIZE_14,
                              color: AppColor.DARK_TEXT_COLOR),
                          controller: homeController.descriptionController,
                          decoration:  InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                            hintText: "Напишите, что нужно сделать",
                            hintStyle: TextStyle(
                                color: AppColor.DARK_GREY_COLOR,
                                fontFamily: Weights.regular,
                                fontSize: AppSizes.SIZE_13
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      AppText(
                          title: "Адрес, например: ул. Исанова 10 или мкр. Джал ",
                          size: size.height * 0.016,
                          maxLines: 1,
                          overFlow: TextOverflow.ellipsis,
                          color: AppColor.DARK_TEXT_COLOR,

                          fontFamily: Weights.medium),
                      SizedBox(height: Get.height*0.01),
                      AddressWidget(text1: "Select Address",text: "",),
                      const SizedBox(height: 24.0),

                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                AttachButton(
                                  onTap: () {
                                    Get.defaultDialog(
                                      title: '',
                                      content: attachImageDialog(),
                                    );
                                  },
                                  isPostfixIcon: true,
                                  text:  Text(
                                      homeController.file == null
                                        ? 'Фото':"File Image",
                                    style: TextStyle(
                                      fontSize: 14.0,


                                      fontFamily: Weights.medium,
                                      color: AppColors.blackColor,
                                    ),
                                  ),

                                  postfixIcon:  homeController.file == null
                                      ?Icons.keyboard_arrow_down:Icons.image,
                                ),
                                const SizedBox(width: 16.0),
                                AttachButton(
                                  onTap: () {
                                    Get.bottomSheet(
                                      budgetSheet(width),
                                      enableDrag: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(16.0),
                                          topRight: Radius.circular(16.0),
                                        ),
                                      ),
                                      backgroundColor: Colors.white,
                                      isScrollControlled: true,
                                    );
                                  },
                                  text:  Text(
                                    'Бюджет',
                                    style: TextStyle(
                                      fontSize: 13.0,
                                     fontFamily: Weights.medium,
                                      color: AppColors.blackColor,
                                    ),
                                  ),
                                  isPrefixIcon: true,
                                  prefixIcon: Icons.bar_chart,
                                ),


                              ],
                            ),
                            homeController.file == null?SizedBox.shrink():
                            SizedBox(height: 20),
                            homeController.file == null?SizedBox.shrink():
                            GestureDetector(
                              onTap: (){
                              setState(() {
                                homeController.file = null;
                              });
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    decoration:BoxDecoration(
                                        border: Border.all(color: AppColor.primaryColor,
                                        ),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        homeController.file as File,
                                        height: Get.height * 0.07,
                                        width: Get.height * 0.08,
                                        fit: BoxFit.cover,


                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 3,
                                      top: 3,

                                      child: Icon(Icons.cancel_outlined,color: Colors.red,))
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            AttachButton(
                              onTap: () {
                                postAJobController.chooseDate(context: context);
                              },
                              text: Obx(
                                    () => Text(
                                  DateFormat('dd-MM-yyyy')
                                      .format(postAJobController.selectDate.value)
                                      .toString(),
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: AppColors.blackColor,
                                        fontFamily: Weights.medium,

                                      ),
                                ),
                              ),
                              isPrefixIcon: true,
                              isPostfixIcon: false,
                              prefixIcon: Icons.calendar_today,
                              postfixIcon: Icons.close,
                            ),

                             SizedBox(height: 20),
                            Divider(
                              color: AppColors.greyColor.withOpacity(0.5),
                              thickness: 0.6,
                            ),
                            const SizedBox(height: 5.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.call,
                                  size: 20,
                                  color: AppColors.greyColor,
                                ),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 3.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:  [
                                        Text(
                                          homeController.profileMOdel?.phoneNo??"",
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: AppColors.blackColor,
                                            fontFamily: Weights.medium,

                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          'Специалисты могут видеть мой номер телефона',
                                          style: TextStyle(
                                            fontSize: 13.0,
                                            color: AppColors.greyColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Obx(() => FlutterSwitch(

                                  value: postAJobController.status.value,
                                  onToggle: postAJobController.toggle,
                                  height: 24,
                                  width: 50,
                                  padding: 2.0,
                                  inactiveColor: AppColors.greyColor,
                                  activeColor: Colors.green,
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  bool validate() {


    if (homeController.descriptionController.text.isEmpty) {
      showErrorToast( 'Требуется описание');

      return false;
    }
    if (postAJobController.addressController.text.isEmpty) {
      showErrorToast( 'Требуется адрес');

      return false;
    }



    return true;
  }


  List<DropdownMenuItem<int>> nameDataList({var dataList}) {
    List<DropdownMenuItem<int>> outputList = [];
    for (int i = 0; i < dataList.length; i++) {
      outputList.add(DropdownMenuItem<int>(
          value: dataList[i].id,
          child: AppText(
            title: dataList[i].name,
            size:16,
            color: AppColors.blackColor,
            fontFamily: Weights.regular,
          )));
    }
    return outputList;
  }

  Widget attachImageDialog() => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: (){
              Navigator.pop(context);
              HelperFunctions.pickImage(
                  ImageSource.camera)
                  .then((value) {
                setState(() {
                  homeController.file = value;
                  debugPrint(homeController.file.toString());

                });
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Icon(Icons.camera_alt,
                  size: 70.0,
                  color: AppColors.blueColor,
                ),
                SizedBox(height: 8.0),
                Text('Камера',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: AppColors.blueColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 24.0),
          TextButton(
            onPressed: (){
              Navigator.pop(context);
              HelperFunctions.pickImage(
                  ImageSource.gallery)
                  .then((value) {
                setState(() {
                  homeController.file = value;
                  debugPrint(homeController.file.toString());
                });
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Icon(Icons.photo,
                  size: 70.0,
                  color: AppColors.blueColor,
                ),
                SizedBox(height: 8.0),
                Text('Галерея',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: AppColors.blueColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 20.0),
    ],
  );

  Widget addressSheet(width) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      const SizedBox(height: 24.0),
      const Padding(
        padding: EdgeInsets.only(left: 16.0),
        child:  Text('Your Location',
          style: TextStyle(
            fontSize: 18.0,
            color: AppColors.blackColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(height: 16.0),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          height: 50.0,
          color: AppColors.greyColor.withOpacity(0.4),
          child: TextFormField(
            controller: homeController.locController,
            keyboardType: TextInputType.streetAddress,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              hintText: 'Enter your address',
            ),
          ),
        ),
      ),
      const SizedBox(height: 150.0),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: ElevatedButton(
          onPressed: (){
            Get.back();
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(width, 50.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Center(
            child: Text('Submit',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ],
  );

  Widget budgetSheet(width) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      const SizedBox(height: 24.0),
      const Padding(
        padding: EdgeInsets.only(left: 16.0),
        child: Text('Сколько вы готовы заплатить?',
          style: TextStyle(
            fontSize: 18.0,
            color: AppColors.blackColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(height: 16.0),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          height: 50.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: AppColors.greyColor.withOpacity(0.4),
            border: Border.all(
              color: AppColors.blueColor,
              width: 1.5,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 16.0),
              const Text('до',
                style: TextStyle(
                  fontSize: 15.0,
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: TextFormField(
                  controller: homeController.budgetController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(bottom: 16.0, top: 16.0),
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              const Text('сом',
                style: TextStyle(
                  fontSize: 15.0,
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 16.0),
            ],
          ),
        ),
      ),
      const SizedBox(height: 24.0),
      Container(
        margin: const EdgeInsets.only(left: 16.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: AppColors.blueColor,
        ),
        child: const Text('За всю работу',
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      const SizedBox(height: 150.0),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: ElevatedButton(
          onPressed: (){
            Get.back();
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(width, 50.0),
            primary: AppColors.blueColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Center(
            child: Text('Продолжить',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}



