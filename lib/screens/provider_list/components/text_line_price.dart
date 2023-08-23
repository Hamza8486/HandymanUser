import 'package:flutter/material.dart';
import 'package:user_apps/res/colors.dart';

class TextLinePrice extends StatelessWidget {
  final String? text;
  final int? price;

  const TextLinePrice({
    Key? key,
    this.text = 'Lorem Ipsum is simply dummy',
    this.price = 700,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 32.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              text!,
              style: const TextStyle(
                fontSize: 14.0,
                color: AppColors.greyColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 30.0),
          Text(
            '$price сом',
            style: const TextStyle(
              fontSize: 14.0,
              color: AppColors.greyColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
