import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:user_apps/Services/api_manager.dart';
import 'package:user_apps/Services/helper_function.dart';
import 'package:user_apps/widgets/Colors/app_colors.dart';
import 'package:user_apps/widgets/Fonts/app_fonts.dart';
import 'package:user_apps/widgets/Paddings/padding.dart';
import 'package:user_apps/widgets/SnackBar/snack_bar.dart';
import 'package:user_apps/widgets/app_button.dart';
import 'package:user_apps/widgets/app_text.dart';
import 'package:user_apps/widgets/back_button.dart';


class OtpScreen extends StatefulWidget {
  OtpScreen({Key? key, this.phone,})
      : super(key: key);

  var phone;

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {


  TextEditingController textEditingController1 = TextEditingController();



  late AuthCredential _phoneAuthCredential;
  final otpController = TextEditingController();

  late User _firebaseUser;
  String? _verificationCode;

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.phone.toString(),
      verificationCompleted: (PhoneAuthCredential credential) async {
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
        showErrorToast("Неправильный номер телефона");
      },
      codeSent: (String verificationID, int? resendToken) {
        setState(() {
          _verificationCode = verificationID;
        });
      },
      codeAutoRetrievalTimeout: (String verificationID) {
        if(mounted){
          setState(() {
            _verificationCode = verificationID;
          });
        }
      },
      timeout: Duration(seconds: 120),
    );
  }

  bool isLoading = false;

  String currentText = "";
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  final formKey = GlobalKey<FormState>();
  String ? token;

  void getToken() async {
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();

    HelperFunctions.saveInPreference("token", token!);
    print("token");
    print(token);
  }

  @override
  void initState() {
    // textEditingController1 = TextEditingController();
    // initSmsListener();
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      if (mounted) {
        _startTimer();
        _verifyPhone();
      }
    });
    textEditingController1 = TextEditingController();
    // initSmsListener();
    getToken();
    HelperFunctions.getFromPreference("tokem").then(
            (value) {
          setState(() {
            token = value;
          });
          print(token);
          print(token);
          print(token);
        });
  }


  Timer? _timer;
  int _counter = 120;

  bool isShowResend = false;
  void _startTimer() {
    setState(() {
      isShowResend = true;
    });
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec, (Timer timer) => setState(() {
      if(_counter>0){
        _counter--;
      }else{
        _timer?.cancel();
        _counter = 120;
        setState(() {
          isShowResend = false;
        });
      }
    }),
    );
  }
  formatedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: Padding(
        padding: AppPaddings.symetric,
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: backBtn(
                  context: context,
                  onTap: () {
                    Get.back();
                  }),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      height: size.height * .2,
                      width: size.width * .7,
                    ),
                    AppText(
                      // title: "Verify your\nPhone Number",
                      title: "Введите код из смс\nотправленный на",
                      size: size.height * 0.023,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.bold,
                      color: AppColor.primaryColor,
                      fontFamily: Weights.bold,
                    ),
                    SizedBox(
                      height: size.height * .01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        AppText(
                          title: widget.phone,
                          size: size.height * 0.019,
                          textAlign: TextAlign.center,
                          color: AppColor.DARK_TEXT_COLOR,
                          fontFamily: Weights.medium,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * .06,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.05),
                      child: PinCodeTextField(
                        appContext: context,
                        autoDisposeControllers: false,
                        length: 6,
                        animationType: AnimationType.fade,
                        validator: (v) {
                          if (v!.length < 5) {
                            //return "Please enter valid otp";
                            return "Пожалуйста, введите правильный код";
                          } else {
                            return null;
                          }
                        },
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          activeColor: AppColor.primaryColor,
                          inactiveColor: AppColor.GREY_COLOR,
                          inactiveFillColor: AppColor.WHITE_COLOR,
                          activeFillColor: AppColor.WHITE_COLOR,
                          selectedFillColor: AppColor.WHITE_COLOR,
                          selectedColor: AppColor.primaryColor,
                          disabledColor: AppColor.primaryColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        cursorColor: AppColor.primaryColor,
                        animationDuration:
                        const Duration(milliseconds: 300),
                        enableActiveFill: true,
                        errorAnimationController: errorController,
                        controller: textEditingController1,
                        keyboardType: TextInputType.number,
                        onCompleted: (v) {
                          debugPrint("Completed");
                        },
                        onChanged: (value) {
                          debugPrint(value);
                          setState(() {
                            currentText = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          debugPrint("Allowing to paste $text");
                          return true;
                        },
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),

                   isLoading == false?
                    AppButton(
                      buttonWidth: size.width,
                      buttonRadius: BorderRadius.circular(25),
                      fontFamily: Weights.semi,
                      fontWeight: FontWeight.w700,
                      textSize: size.height * 0.02,
                      //buttonName: "Verify",
                      buttonName: "Продолжить",
                      buttonColor: AppColor.primaryColor,
                      textColor: AppColor.WHITE_COLOR,
                      onTap: () async{

                        if (currentText != null &&
                            currentText.length == 6) {

                         setState(() {
                           isLoading=true;
                         });



                          try{
                            await FirebaseAuth.instance.signInWithCredential(PhoneAuthProvider.credential(
                                verificationId: _verificationCode.toString(), smsCode: currentText)).then((value) {
                              if(value.user!=null){
                                print("object");
                                ApiManger.loginResponse(context: context,
                                          phone: widget.phone,
                                          token: token

                                      );

                              }
                            });
                          }catch(e){
                            isLoading=false;
                            showErrorToast("Неверный код подтверждения");
                            print("error $e");
                          }


                        }
                        else{
                          isLoading=false;
                          showErrorToast("Неверный код подтверждения");
                        }


                        // if (currentText != null &&
                        //     currentText.length == 6) {
                        //   _submitOTP();
                        // }
                        // else {
                        //   //showErrorToast("Please enter valid code");
                        //   showErrorToast(
                        //       "Пожалуйста, введите действительный код");
                        // }
                      },
                    )

                        :Center(
                      child: CircularProgressIndicator(
                        backgroundColor: AppColor.primaryColor.withOpacity(0.4),
                        valueColor: AlwaysStoppedAnimation<Color>(
                            AppColor.primaryColor ),
                      ),
                    ),


                    SizedBox(height: Get.height*0.038,),



                    isShowResend == false?
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          _startTimer();
                          _verifyPhone();
                        });
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppText(
                              title:"Didn’t received code?  ",
                              size: size.height * 0.016,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w600,
                              color: AppColor.greyColor,
                              fontFamily: "Poppins",
                            ),
                            AppText(
                              title:"Resend ",
                              size: size.height * 0.017,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Poppins",
                              color: AppColor.DARK_TEXT_COLOR,

                            ),
                          ],
                        ),
                      ),
                    )


                        : Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Center(child:
                      AppText(title: '${formatedTime(timeInSecond: _counter)}', size: 14, color: AppColor.DARK_TEXT_COLOR,

                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins",
                      )
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }









}
