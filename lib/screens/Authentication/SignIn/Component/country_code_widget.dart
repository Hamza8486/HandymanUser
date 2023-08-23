import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:get/get.dart';
import 'package:user_apps/widgets/Colors/app_colors.dart';
import 'package:user_apps/widgets/Fonts/app_fonts.dart';
import 'package:user_apps/widgets/app_dimensions.dart';


class CountryCodeWid extends StatefulWidget {
  final TextEditingController phoneController;

  final Function(dynamic code) onPickCode;

  const CountryCodeWid({
    required this.phoneController,
    required this.onPickCode,
  });

  @override
  _CountryCodeWidState createState() => _CountryCodeWidState();
}

class _CountryCodeWidState extends State<CountryCodeWid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.058,
      width: Get.width,
      decoration: BoxDecoration(
          border: Border.all(color: AppColor.DARK_TEXT_COLOR, width: 1),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(
              decoration:
                  const BoxDecoration(border: Border(bottom: BorderSide.none)),
              child: CountryCodePicker(
                showFlag: false,
                initialSelection: '+996',
                onChanged: widget.onPickCode,
                dialogTextStyle: const TextStyle(
                  fontSize: AppDimensions.FONT_SIZE_13,
                ),
                textStyle: TextStyle(
                  fontSize: AppDimensions.FONT_SIZE_15,
                  color: AppColor.DARK_TEXT_COLOR,
                  fontFamily: Weights.medium,
                ),
                padding: EdgeInsets.zero,
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
                alignLeft: false,
              )),
          VerticalDivider(thickness: .5, color: AppColor.BLACK_COLOR),
          SizedBox(
            width: Get.width * 0.01,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide.none, bottom: BorderSide.none),
                ),
                child: TextField(
                  cursorColor: AppColor.DARK_GREY_COLOR,

                  controller: widget.phoneController,
                  style: TextStyle(
                      fontFamily: Weights.medium,
                      fontSize: AppDimensions.FONT_SIZE_15,
                      color: AppColor.DARK_TEXT_COLOR),
                  decoration: InputDecoration(
                    //hintText: 'Phone Number',
                    hintText: 'Номер телефона',
                    hintStyle: TextStyle(
                      color: AppColor.DARK_TEXT_COLOR.withOpacity(0.7),
                      fontSize: AppDimensions.FONT_SIZE_14,
                      fontFamily: Weights.regular,
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
