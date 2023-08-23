
// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_apps/Services/api_manager.dart';
import 'package:user_apps/res/colors.dart';
import 'package:user_apps/screens/BottomTabsView/home/controllers/home_controller.dart';
import 'package:user_apps/screens/BottomTabsView/profile/controllers/profile_controller.dart';
import 'package:user_apps/widgets/Colors/app_colors.dart';
import 'package:user_apps/widgets/Fonts/app_fonts.dart';
import 'package:user_apps/widgets/Loader/loader.dart';
import 'package:user_apps/widgets/app_text.dart';
import 'package:user_apps/widgets/custom_button.dart';

import '../../../../widgets/SnackBar/snack_bar.dart';




class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key? key,this.data}) : super(key: key);
  var data;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController emailController = TextEditingController();
  File? _file;
  final profileController = Get.put(HomeController());
  final picker = ImagePicker();
  TextEditingController nameController = TextEditingController();
  handleChooseFromGallery() async {
    Navigator.pop(context);
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery,
        imageQuality: 40
    );
    setState(() {
      if (image != null) {
        File file = File(image.path);
        int sizeInBytes = file.lengthSync();
        double sizeInMb = sizeInBytes / (1024 * 1024);
        print('IMAGE SIZE : $sizeInMb');
        if (sizeInMb > 1) {
          print('$image size is $sizeInMb');
          showErrorToast('${image.name} is more than 1 MB');
          image == null;
        }
        else{
          _file = File(image.path);
        }



      }

      else {
        print('Фото не выбрано.');
      }
    });
  }

  handleTakePhoto() async {
    Navigator.pop(context);
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera,
    imageQuality: 40

    );
    setState(() {
      if (image != null) {
        _file = File(image.path);
      } else {
        print('No image selected.');
      }
    });
  }

  clearImage() {
    setState(() {});
  }

  selectImage(parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            title: const Text(
              "Select Display Picture",
            ),
            backgroundColor: Colors.white,
            children: <Widget>[
              SimpleDialogOption(
                child: const Text(
                  "Камера",
                ),
                onPressed: handleTakePhoto,
              ),
              SimpleDialogOption(
                child: Text("Галерея"),
                onPressed: handleChooseFromGallery,
              ),
              SimpleDialogOption(
                child: Text("Отмена"),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
  }

  @override
  void initState() {

    super.initState();
    nameController.text = widget.data.firstName??"";
    emailController.text = widget.data.email??"";

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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.02,
                        vertical: size.height * 0.018 ),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 10),
                      child:    Row(
                        children: [
                          GestureDetector(
                              onTap: (){
                                Get.back();
                              },
                              child: Icon(Icons.arrow_back_outlined)),
                          SizedBox(width: 20,),
                          AppText(
                              title: "Изменить профиль",
                              size: size.height * 0.022,
                              overFlow: TextOverflow.ellipsis,
                              color: AppColor.DARK_TEXT_COLOR,
                              fontFamily: Weights.semi),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: size.width,
                    height: size.height * 0.15,
                    child: Stack(
                      children: [
                        Center(
                          child: Material(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    MediaQuery.of(context).size.height * 0.1)),
                                side:
                                BorderSide(color: AppColors.blueColor)),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: MediaQuery.of(context).size.height * 0.15,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          MediaQuery.of(context).size.height *
                                              0.1))),
                              padding: EdgeInsets.all(2),
                              child:


                              ClipRRect(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(1000)),
                                  child: _file == null
                                      ? Image.asset(
                                    "assets/images/persons.jpg",
                                    fit: BoxFit.cover,
                                  )
                                      : Image.file(_file as File,fit: BoxFit.cover,)


                              )
                            ),
                          ),
                        ),
                        Positioned(
                            left: size.width * 0.56,
                            top: size.height * 0.1,
                            child: InkWell(
                              onTap: () => selectImage(context),
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: AppColors.blueColor,
                                child: Icon(
                                  Icons.add,
                                  color: AppColor.WHITE_COLOR,
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(height: 36.0),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      'Имя',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: AppColors.greyColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      controller: nameController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Icon(Icons.person,
                              color: AppColors.blueColor),
                        ),
                        contentPadding: EdgeInsets.only(top: 16.0, left: 0.0),
                        prefixStyle: TextStyle(
                          fontSize: 15.0,
                          color: AppColors.blackColor,
                        ),
                        hintText: 'Напишите имя',
                        hintStyle: TextStyle(
                          fontSize: 15.0,
                          color: AppColors.greyColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      'почта Email',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: AppColors.greyColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      autofocus: true,
                      controller: emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Icon(Icons.email,
                              color: AppColors.blueColor),
                        ),
                        contentPadding: EdgeInsets.only(top: 16.0, left: 0.0),
                        prefixStyle: TextStyle(
                          fontSize: 15.0,
                          color: AppColors.blackColor,
                        ),
                        hintText: 'abcd@gamil.com',
                        hintStyle: TextStyle(
                          fontSize: 15.0,
                          color: AppColors.greyColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 80.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: CustomButton(
                      onTap: (){
                      if (validate()){

                        appLoader(context, AppColor.primaryColor);
                        profileController.profileMOdel!.firstName = nameController.text;
                        profileController.profileMOdel!.email = emailController.text;
                        profileController.profileMOdel!.image = _file.toString();
                        ApiManger().editProfile(
                          userId: profileController.userId.value,
                          name: nameController.text,
                          email: emailController.text,
                          image: _file,
                          context: context
                        );
                      }
                      },
                      width: width,
                      height: 55.0,
                      btnColor: AppColor.primaryColor,
                      btnText: 'Обновить',
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool validate() {
    // if (_file == null) {
    //   showSnackBar(context, 'Image required');
    //
    //   return false;
    // }
    if (nameController.text.isEmpty) {
      showErrorToast( 'Требуется имя');

      return false;
    }
    if (emailController.text.isEmpty) {
      showErrorToast( 'Требуется email');

      return false;
    }
    return true;
  }
}