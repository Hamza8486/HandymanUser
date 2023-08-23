// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:user_apps/Services/helper_function.dart';
import 'package:user_apps/res/colors.dart';
import 'package:user_apps/screens/Authentication/SignIn/View/sign_view.dart';
import 'package:user_apps/screens/BottomTabsView/home/controllers/home_controller.dart';
import 'package:user_apps/screens/BottomTabsView/home/controllers/sub_controller.dart';
import 'package:user_apps/screens/BottomTabsView/my_requests/Controller/controller.dart';
import 'package:user_apps/screens/BottomTabsView/post_a_job/controllers/post_a_job_controller.dart';
import 'package:user_apps/screens/BottomTabsView/profile/components/edit_profile_screen.dart';
import 'package:user_apps/screens/BottomTabsView/support_section/controllers/support_section_controller.dart';
import 'package:user_apps/screens/PrivacyPolicy/View/view.dart';
import 'package:user_apps/screens/favorite/my_favorite_screen.dart';
import 'package:user_apps/screens/my_requests/controllers/my_request_controller.dart';
import 'package:user_apps/screens/provider_detail/controller/provider_detail_controller.dart';
import 'package:user_apps/screens/provider_list/controller/provider_list_controller.dart';
import 'package:user_apps/screens/review/controller/review_controller.dart';
import 'package:user_apps/widgets/Colors/app_colors.dart';
import 'package:user_apps/widgets/Fonts/app_fonts.dart';
import 'package:user_apps/widgets/SnackBar/snack_bar.dart';
import 'package:user_apps/widgets/app_text.dart';
import 'package:user_apps/widgets/custom_button.dart';

import 'components/profile_buttons.dart';

class ProfileScreen extends StatelessWidget {
   ProfileScreen({Key? key}) : super(key: key);

  final profileController  = Get.put(HomeController());

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
              height: size.height / 8.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.02,
                        vertical: size.height * 0.018),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: AppText(
                          title: "Профиль",
                        size: Get.height * 0.018,
                        overFlow: TextOverflow.ellipsis,
                        color: AppColor.DARK_TEXT_COLOR,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,),
                    ),
                  ),
                ],
              ),
            ),
          ),


          // profileController.profileMOdel?.id == null?Column(
          //   children: [
          //     SizedBox(height: Get.height*0.4,),
          //     Center(
          //       child: GestureDetector(
          //         onTap: (){
          //           Get.to(SignInView());
          //         },
          //         child: AppText(
          //             title: "Войти",
          //             size: Get.height * 0.02,
          //             overFlow: TextOverflow.ellipsis,
          //             color: AppColor.primaryColor,
          //             fontFamily: Weights.semi),
          //       ),
          //     ),
          //   ],
          // ):
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        const SizedBox(height: 16.0),
                        Obx(
                                () {
                              return
                                profileController.isProfileLoading.value
                                    ?  Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.black26,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          AppColor.primaryColor //<-- SEE HERE

                                      ),
                                    ))
                                    :

                                profileData();
                            }
                        ),
                        const SizedBox(height: 12.0),
                        const Divider(
                          thickness: 0.7,
                          color: AppColors.greyColor,
                        ),
                        ProfileButtons(
                          onTap: () {
                            Get.put(HomeController()).allFavData(profileController.userId.value);
                            Get.to(MyFavouriteScreen(

                            ),
                                transition: Transition.rightToLeft
                            );

                          },
                          title: 'Избранное',
                          icon: Icons.support,
                        ),
                        const Divider(
                          thickness: 0.7,
                          color: AppColors.greyColor,
                        ),
                        ProfileButtons(
                          onTap: () {
                            Share.share('https://yamaster.kg/');
                          },
                          title: 'Пригласить друга',
                          icon: Icons.person,
                        ),
                        // const Divider(
                        //   thickness: 0.7,
                        //   color: AppColors.greyColor,
                        // ),
                        // ProfileButtons(
                        //   onTap: () {},
                        //   title: 'Notifications',
                        //   icon: Icons.notifications,
                        // ),
                        const Divider(
                          thickness: 0.7,
                          color: AppColors.greyColor,
                        ),
                        ProfileButtons(
                          onTap: () {
                            Get.to(PrivacyPolicy(),
                                transition: Transition.rightToLeft);
                          },
                          title: 'Правила сервиса',
                          icon: Icons.policy,
                        ),
                        const Divider(
                          thickness: 0.7,
                          color: AppColors.greyColor,
                        ),
                        ProfileButtons(
                          onTap: () {
                            showErrorToast("Эта функция в разработке");
                          },
                          title: 'Безопасная оплата',
                          icon: Icons.payment,
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: CustomButton(
                      onTap: () {

                      },
                      width: width,
                      height: 55.0,

                      btnColor: AppColor.primaryColor,
                      btnText: 'Приложение специалиста',
                    ),
                  ),

                  const SizedBox(height: 30.0),
                  GestureDetector(
                    onTap: ()async{
                      await  Get.delete<HomeController>();
                      await  Get.delete<SubController>();
                      await  Get.delete<SelectTab>();
                      await  Get.delete<PostAJobController>();
                      await  Get.delete<SupportSectionController>();
                      await  Get.delete<MyRequestController>();
                      await  Get.delete<ProviderDetailController>();
                      await  Get.delete<ProviderListController>();
                      await  Get.delete<ReviewController>();

                      HelperFunctions.clearPrefs();
                      Get.offAll(SignInView());
                    },
                    child: Center(
                      child: Text(
                        'Выход',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: Get.height * 0.016,

                          color: AppColor.DARK_TEXT_COLOR,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget profileData() {

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: Stack(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: profileController.profileMOdel?.image??"" , fit: BoxFit.cover,
                          errorWidget:(context, url, error) => ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/images/person.png',
                              fit: BoxFit.cover,
                            ),
                          ),

                          placeholder: (context, url) =>


                          const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.blueColor,
                              )),



                        ),
                      ),







                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 23,
                      height: 23,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.blueColor,
                      ),
                      child: Icon(
                        Icons.camera_alt_rounded,
                        color: AppColor.WHITE_COLOR,
                        size: 12,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    profileController.profileMOdel?.firstName ?? "",
                    style: TextStyle(
                      fontSize: 17.0,
                      color: AppColors.blackColor,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    profileController.profileMOdel?.phoneNo ?? "",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: AppColors.greyColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    profileController.profileMOdel?.email??"email@gmail.com",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: AppColors.greyColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Get.to(EditProfileScreen(data: profileController.profileMOdel ,),

                transition: Transition.rightToLeft);
              },
              child: const Text(
                'Изменить',
                style: TextStyle(
                  fontSize: 16.0,
                  color: AppColors.blueColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ));
  }
}

