import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_apps/res/colors.dart';
import 'controller/success_controller.dart';

class SuccessScreen extends GetView<SuccessController> {
  SuccessScreen({Key? key}) : super(key: key);

  final SuccessController successController = Get.put(SuccessController());

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Expanded(
                flex: 1,
                child: SizedBox(),
            ),
            Center(
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.blueColor.withOpacity(0.3),
                ),
                child: const Center(
                  child: Icon(Icons.repeat_rounded, size: 60.0),
                ),
              ),
            ),
            const SizedBox(height: 36.0),
            const Center(
              child: Text('You will receive answers \nwithin 5 minutes',
              textAlign: TextAlign.center,
                style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: AppColors.blueColor,
              ),
              ),
            ),
            const SizedBox(height: 36.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text('Provider will place a bid to your '
                  'job in 5 minutes, You can see it on "My Request Section"',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blueColor,
                ),
              ),
            ),
            const Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 24.0),
              child: ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(width, 60.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text('Ok',
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}