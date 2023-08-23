import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:user_apps/widgets/Fonts/app_fonts.dart';

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
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: AppColors.blueColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:  [
            Expanded(
              child: Text(
                'Внимание',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                 fontWeight: FontWeight.bold,
                 fontFamily: Weights.bold
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
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 24.0),
            text("•	Выбирайте специалистов по отзывам и рейтингу."),
            text("•	Если договорились о найме, то в чате нажмите кнопку «Выбрать специалиста», чтобы зафиксировать факт найма."),
            text("•	Оставляйте отзывы после выполнения работы и получайте скидки на следующие заказы. Отзывы мотивируют специалистов работать качественнее."),
            text("•	При передаче предоплаты или начиная работу с большим объемом, обязательно заключайте договор или берите расписку."),

          ],
        ),
      ),
    );
  }

  Widget text(text1) =>  Padding(
    padding: EdgeInsets.only(bottom: 5.0),
    child: Text(text1,
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.white,

        fontFamily: Weights.semi,
        fontWeight: FontWeight.w300,
      ),
    ),
  );

}
