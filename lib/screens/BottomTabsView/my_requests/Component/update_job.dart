// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:user_apps/Services/api_manager.dart';
import 'package:user_apps/Services/helper_function.dart';
import 'package:user_apps/res/colors.dart';
import 'package:user_apps/screens/BottomTabsView/home/controllers/home_controller.dart';

import 'package:user_apps/screens/BottomTabsView/post_a_job/components/attach_button.dart';
import 'package:user_apps/screens/BottomTabsView/post_a_job/controllers/post_a_job_controller.dart';
import 'package:user_apps/screens/BottomTabsView/profile/controllers/profile_controller.dart';

import 'package:user_apps/widgets/AppDimensions/app_dimensions.dart';
import 'package:user_apps/widgets/Colors/app_colors.dart';
import 'package:user_apps/widgets/Fonts/app_fonts.dart';
import 'package:user_apps/widgets/Loader/loader.dart';
import 'package:user_apps/widgets/app_text.dart';


class UpdateJobView extends StatefulWidget {
   UpdateJobView({Key? key,this.data}) : super(key: key);
  var data;

  @override
  State<UpdateJobView> createState() => _UpdateJobViewState();
}

class _UpdateJobViewState extends State<UpdateJobView> {

  var aboutController = TextEditingController();
  var addressController = TextEditingController();
  var budgetController = TextEditingController();
  final  postAJobController = Get.put(PostAJobController());
  var phoneNumber;

  final profileController = Get.put(HomeController());
  String? countryValue;
  File ?file;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    aboutController.text = widget.data.description??"";
    addressController.text = widget.data.address??"";
    budgetController.text =
        widget.data.budget==null?"0":
        widget.data.budget.toString();
    phoneNumber =profileController.profileMOdel?.phoneNo??"";


  }


  @override
  Widget build(BuildContext context) {
    var size = Get.size;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
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
                        vertical: size.height * 0.008 ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
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
                            ),
                            SizedBox(width: Get.width*0.02,),
                            AppText(
                                title: "Редактирование",
                              size: Get.height * 0.018,
                              overFlow: TextOverflow.ellipsis,
                              color: AppColor.DARK_TEXT_COLOR,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,),
                          ],
                        ),



                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 10),
                          child: GestureDetector(
                            onTap: (){
                              appLoader(context, AppColor.primaryColor);
                              ApiManger().updateJobProvider(
                                image: file,
                                id: widget.data.cusId.toString(),
                                desc: aboutController.text,
                                address: addressController.text,
                                budget: budgetController.text,
                                phone: phoneNumber.toString(),
                                jobId: widget.data.id.toString(),

                                context: context,


                              );
                            },
                            child: AppText(
                                title: "Обновить",
                                size: size.height * 0.02,
                                overFlow: TextOverflow.ellipsis,
                                color: AppColor.primaryColor,
                                fontFamily: Weights.semi),
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


                    SizedBox(height: Get.height*0.025),
                    AppText(
                        title: "Что нужно сделать?",
                        size: size.height * 0.02,
                        overFlow: TextOverflow.ellipsis,
                        color: AppColor.DARK_TEXT_COLOR,
                        fontFamily: Weights.semi),
                    SizedBox(height: Get.height*0.01),
                    Container(
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
                      child: TextFormField(
                        maxLines: 3,
                        controller: aboutController,
                        decoration:  InputDecoration(
                          border: InputBorder.none,
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                          hintText: "Напишите подробнее о задаче",
                          hintStyle: TextStyle(
                              color: AppColor.DARK_TEXT_COLOR,
                              fontFamily: Weights.regular,
                              fontSize: AppSizes.SIZE_12
                          ),
                        ),
                      ),
                    ),
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
                                  file == null
                                      ? 'Фото':"File Image",
                                  style: TextStyle(
                                    fontSize: 13.0,

                                    fontWeight: FontWeight.w500,
                                    color: AppColors.blackColor,
                                  ),
                                ),

                                postfixIcon:  file == null
                                    ?Icons.keyboard_arrow_down:Icons.image,
                              ),
                              const SizedBox(width: 16.0),
                              AttachButton(
                                onTap: () {
                                  Get.bottomSheet(
                                    addressSheet(width),
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
                                text: const Text(
                                  'Адрес',
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.blackColor,
                                  ),
                                ),
                                isPrefixIcon: true,
                                isPostfixIcon: true,
                                prefixIcon: Icons.location_on,
                                postfixIcon: Icons.close,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
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
                                text: const Text(
                                  'Бюджет',
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.blackColor,
                                  ),
                                ),
                                isPrefixIcon: true,
                                prefixIcon: Icons.bar_chart,
                              ),
                              const SizedBox(width: 16.0),
                              AttachButton(
                                onTap: () {
                                  postAJobController.chooseDate(context: context);
                                },
                                text: Obx(
                                      () => Text(
                                    DateFormat('dd-MM-yyyy')
                                        .format(postAJobController.selectDate.value)
                                        .toString(),
                                  ),
                                ),
                                isPrefixIcon: true,
                                isPostfixIcon: false,
                                prefixIcon: Icons.calendar_today,
                                postfixIcon: Icons.close,
                              ),
                            ],
                          ),
                          const SizedBox(height: 45.0),
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
                                        profileController.profileMOdel?.phoneNo??"",
                                        style: TextStyle(
                                          fontSize: 17.0,
                                          color: AppColors.blackColor,
                                          fontWeight: FontWeight.w700,
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
    );
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
                  file = value;
                  debugPrint(file.toString());

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
                  file = value;
                  debugPrint(file.toString());
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
        child:  Text('Ваш адрес',
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
            controller: addressController,
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
            child: Text('Опубликовать',
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
        child: Text('Сколько вы можете заплатить?',
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
                  controller: budgetController,
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
        child: const Text('За работу',
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
            child: Text('Отправить',
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



