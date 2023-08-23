import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_apps/screens/Authentication/OtpScreen/otp_screen.dart';
import 'package:user_apps/screens/Authentication/SignIn/Component/country_code_widget.dart';
import 'package:user_apps/screens/BottomTabsView/profile/components/service_rule.dart';
import 'package:user_apps/widgets/Colors/app_colors.dart';
import 'package:user_apps/widgets/Fonts/app_fonts.dart';
import 'package:user_apps/widgets/Paddings/padding.dart';
import 'package:user_apps/widgets/SnackBar/snack_bar.dart';
import 'package:user_apps/widgets/app_button.dart';
import 'package:user_apps/widgets/app_dimensions.dart';
import 'package:user_apps/widgets/app_text.dart';


class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  TextEditingController phoneController = TextEditingController();
  bool isLoading = false;

  late String phoneNumber;
  String value = '+996';



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(
              height: size.height * .38,
            ),
            Padding(
              padding: AppPaddings.horizontal1,

            ),
            SizedBox(
              height: size.height * .003,
            ),
            Padding(
              padding: AppPaddings.horizontal1,
              child: AppText(
                //title: 'SignIn into your Account',
                title: 'Войти в аккаунт',
                size: AppDimensions.FONT_SIZE_18,
                color: AppColor.DARK_TEXT_COLOR,
                fontFamily: Weights.semi,
                fontWeight: FontWeight.w800,
              ),
            ),


            SizedBox(
              height: size.height * .04,
            ),
            Padding(
              padding: AppPaddings.horizontal1,
              child: Align(
                alignment: Alignment.centerLeft,

              ),
            ),
            SizedBox(
              height: size.height * .01,
            ),
            Padding(
              padding: AppPaddings.horizontal1,
              child: CountryCodeWid(
                onPickCode: (code) {
                  setState(() {
                    value = code.toString();
                  });
                },
                phoneController: phoneController,
              ),
            ),
            SizedBox(
              height: size.height * .02,
            ),
            GestureDetector(
              onTap: (){
                Get.to(ServiceRule(),
                    transition: Transition.rightToLeft
                );
              },
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      //title: 'Login as Guest',
                      title: 'Нажимая "Продолжить" вы соглашаетесь с ',
                      fontWeight: FontWeight.w700,
                      size:  AppDimensions.FONT_SIZE_12,
                      color: Colors.grey,

                      fontFamily:"Poppins",
                    ),
                    AppText(
                      //title: 'Login as Guest',
                      title: 'правилами сервиса',
                      fontWeight: FontWeight.w700,
                      size:  AppDimensions.FONT_SIZE_12,
                      color: AppColor.primaryColor,
                      fontFamily: "Poppins",
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * .04,
            ),
            isLoading==false?

            Padding(
              padding: AppPaddings.horizontal1,
              child: AppButton(
                buttonWidth: size.width,

                buttonRadius: BorderRadius.circular(25),
                fontFamily: Weights.bold,
                fontWeight: FontWeight.bold,
                textSize: size.height * 0.02,
                //buttonName: "Continue",
                buttonName: "Продолжить",
                buttonColor: AppColor.primaryColor,

                textColor: AppColor.WHITE_COLOR,
                onTap: () {

                  if (validate()) {
                    String number = value + phoneController.text;

                    Get.to(OtpScreen(
                      phone:value + phoneController.text ,
                    ));
                    successToast("Код отправлен на мобильный номер");
                  }
                },

              ),
            ):

            Center(
              child: CircularProgressIndicator(
                backgroundColor: AppColor.primaryColor.withOpacity(0.4),
                valueColor: AlwaysStoppedAnimation<Color>(
                    AppColor.primaryColor ),
              ),
            )

            ,


          ],
        ),
      ),
    );
  }

  bool validate() {
    phoneNumber = phoneController.text;
    if (phoneNumber.isEmpty) {
      //showErrorToast( 'Phone number is required');
      showErrorToast( 'Укажите номер телефона');

      return false;
    }
    return true;
  }


}
