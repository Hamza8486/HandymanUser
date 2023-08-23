import 'package:flutter/material.dart';

import '../Colors/app_colors.dart';

appLoader(BuildContext context, Color myColors) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            content: SizedBox(
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColor.primaryColor,
                ),
              ),
            ),
          ));
}

Widget shopperLoader() {
  return SizedBox(
    child: Center(
      child: CircularProgressIndicator(
        color: AppColor.primaryColor,
      ),
    ),
  );
}
