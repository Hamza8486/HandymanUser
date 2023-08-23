import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../../../res/colors.dart';
import '../../../widgets/custom_button.dart';

class BidExpand extends StatelessWidget {
  const BidExpand({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ExpandablePanel(
      theme: const ExpandableThemeData(
        useInkWell: false,
        hasIcon: false,
      ),
      header: Container(
        height: 60.0,
        width: width,
        margin: const EdgeInsets.symmetric(horizontal: 24.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: AppColors.blueColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Expanded(
              child: Text(
                'Some alert',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Icon(Icons.keyboard_arrow_down, color: Colors.white),
          ],
        ),
      ),
      collapsed: const SizedBox(),
      expanded: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24.0),
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 24.0),
        width: width,
        decoration: const BoxDecoration(
          color: AppColors.blueColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12.0),
            bottomRight: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
            topLeft: Radius.circular(12.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 24.0),
            text(),
            text(),
            text(),
            text(),
            text(),
            text(),
            text(),
            text(),
            text(),
            const SizedBox(height: 16.0),
            CustomButton(
              onTap: (){},
              width: width,
              height: 55.0,
              btnColor: AppColors.blueColor,
              btnText: 'Button Text',
              borderColor: Colors.white,
              borderWidth: 2.0,
              textColor: Colors.white,
            ),
            const SizedBox(height: 8.0),
            CustomButton(
              onTap: (){},
              width: width,
              height: 55.0,
              btnColor: AppColors.blueColor,
              btnText: 'Button Text',
              borderColor: Colors.white,
              borderWidth: 2.0,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget text() => const Padding(
    padding: EdgeInsets.only(bottom: 5.0),
    child: Text('- Lorem ipsum is a placeholder text commonly used to demonstrate the '
        'visual form of a document or a typeface without relying on meaningful content.',
    style: TextStyle(
      fontSize: 14.0,
      color: Colors.white,
      fontWeight: FontWeight.w300,
    ),
    ),
  );

}
