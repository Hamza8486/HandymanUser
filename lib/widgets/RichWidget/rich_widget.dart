import 'package:flutter/material.dart';
import 'package:user_apps/widgets/Colors/app_colors.dart';
import 'package:user_apps/widgets/Fonts/app_fonts.dart';
import 'package:user_apps/widgets/app_dimensions.dart';


class RichWidget extends StatelessWidget {
  const RichWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

      },
      child: RichText(
        text: TextSpan(
          text: 'Already Have An Account? ',
          style: TextStyle(
              color: AppColor.BLACK_COLOR,
              fontSize: AppDimensions.FONT_SIZE_15,
              fontFamily: Weights.medium),
          children: <TextSpan>[
            TextSpan(
                text: 'Login',
                style: TextStyle(
                  fontFamily: Weights.medium,
                  color: AppColor.primaryColor,
                  fontSize: AppDimensions.FONT_SIZE_16,
                )),
          ],
        ),
      ),
    );
  }
}
