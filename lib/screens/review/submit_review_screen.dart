import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:givestarreviews/givestarreviews.dart';
import 'package:user_apps/Services/api_manager.dart';
import 'package:user_apps/res/colors.dart';
import 'package:user_apps/screens/review/controller/review_controller.dart';
import 'package:user_apps/widgets/Colors/app_colors.dart';
import 'package:user_apps/widgets/Dialogue/dialogue.dart';
import 'package:user_apps/widgets/Fonts/app_fonts.dart';
import 'package:user_apps/widgets/Loader/loader.dart';
import 'package:user_apps/widgets/SnackBar/snack_bar.dart';
import 'package:user_apps/widgets/app_text.dart';

class SubmitReviewScreen extends GetView<ReviewController> {
  SubmitReviewScreen({Key? key,this.data,this.jobId,this.proId}) : super(key: key);
  var data;
  var jobId;
  var proId;

  final ReviewController reviewController = Get.put(ReviewController());

  var amountController = TextEditingController();
  var desc = TextEditingController();

  var rate;

  @override
  Widget build(BuildContext context) {
    final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.backColor,

      body: Column(

        children: [

          Material(
            color: AppColor.WHITE_COLOR,
            elevation: 1,
            child: SizedBox(
              width: Get.width,
              height: Get.height / 8.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: Get.width * 0.04,
                      ),
                      GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.arrow_back_outlined,
                            color: AppColors.blackColor,
                          )),
                      SizedBox(
                        width: Get.width * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: Get.height * 0.018),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: AppText(
                              title: "Отправить",
                              size: Get.height * 0.02,
                              overFlow: TextOverflow.ellipsis,
                              color: AppColor.DARK_TEXT_COLOR,
                              fontFamily: Weights.semi),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(

              child: Column(

                children: [
                  const SizedBox(height: 24.0),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Оцените специалиста',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: AppColors.blackColor,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: StarRating(
                      value: 0,
                      starCount: 5,
                      size: 40,
                      onChanged: (rate) {
                        reviewController.updateRate(rate);
                      },
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Напишите немного о специалисте',
                      style: TextStyle(
                        fontSize: 17.0,
                        color: AppColors.blackColor,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      maxLines: 1,
                      controller: desc,
                      decoration: const InputDecoration(
                          hintText: 'Комментарии',
                          hintStyle: TextStyle(
                            fontSize: 16.0,
                            color: AppColors.greyColor,
                            fontWeight: FontWeight.w600,
                          )
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Сколько вы заплатили ?',
                      style: TextStyle(
                          fontSize: 17.0,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),

                  Container(

                    height: 55.0,
                    width: width,
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Сумма',
                        contentPadding: EdgeInsets.only(top: 8.0),
                        hintStyle: TextStyle(
                          fontSize: 15.0,
                          color: AppColors.greyColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  InkWell(
                    onTap: (){
                      if(validate()){
                        showAlertDialog(context: context,text: "Завершить работу?",
                            yesOnTap: (){
                              Get.back();
                              appLoader(context,AppColors.blueColor);


                              ApiManger().leaveReview(desc: desc.text,price: amountController.text,Id: proId.toString(),rating: reviewController.rate.value,context: context,job: jobId.toString());
                            }
                        );
                      }

                    },
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04),
                      child: Ink(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                          color: AppColors.blueColor,
                        ),
                        height: 55.0,
                        width: width,

                        child: const Center(
                          child: Text('Отправить',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
  bool validate() {

    if (desc.text.isEmpty) {
      showErrorToast ("Пожалуйста напишите отзыв");


      return false;
    }
    if (amountController.text.isEmpty) {
      showErrorToast ("Пожалуйста напишите сумму");


      return false;
    }





    return true;
  }




}
