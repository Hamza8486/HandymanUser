import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_apps/screens/BottomTabsView/home/controllers/home_controller.dart';
import 'package:user_apps/screens/BottomTabsView/my_requests/Component/active.dart';
import 'package:user_apps/screens/BottomTabsView/my_requests/Component/all.dart';
import 'package:user_apps/screens/BottomTabsView/my_requests/Component/completed.dart';
import 'package:user_apps/screens/BottomTabsView/my_requests/Controller/controller.dart';
import 'package:user_apps/widgets/AppDimensions/app_dimensions.dart';
import 'package:user_apps/widgets/Colors/app_colors.dart';
import 'package:user_apps/widgets/app_text.dart';


class RequestView extends StatefulWidget {
   RequestView({Key? key}) : super(key: key);

  @override
  State<RequestView> createState() => _RequestViewState();
}

class _RequestViewState extends State<RequestView> {
  final select = Get.put(SelectTab());
  final profileController = Get.put(HomeController());




  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.02,
                        vertical: Get.height * 0.018),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                              title: "Заявки и чаты",
                              size: Get.height * 0.018,
                              overFlow: TextOverflow.ellipsis,
                              color: AppColor.DARK_TEXT_COLOR,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,),
                          GestureDetector(
                            onTap: (){
                              profileController.allRequestData(profileController.userId.value);
                            },
                            child: Icon(Icons.refresh,
                              color: AppColor.DARK_TEXT_COLOR,
                              size: Get.height*0.03,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),



          Obx(
                  () {
                return Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 15),
                  child: Material(


                    shape: RoundedRectangleBorder(    borderRadius: BorderRadius.circular(10),

                        side: BorderSide(color: AppColor.BLACK_COLOR.withOpacity(0.2))
                    ),

                    child: SizedBox(
                        width: Get.width,


                        height: Get.height * 0.06,
                        child:    Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 6),
                          child: Row(

                            children: [
                              Expanded(
                                child
                                    : tabBusinessList(
                                  text: "Все",
                                  onTap: () {
                                    select.updateTab(0);
                                  },
                                  color: !(select.tab.value == 0)
                                      ? AppColor.WHITE_COLOR
                                      : AppColor.primaryColor,
                                  color1: !(select.tab.value == 0)
                                      ? AppColor.BLACK_COLOR
                                      : AppColor.WHITE_COLOR,
                                ),
                              ),

                              Expanded(
                                child: tabBusinessList(
                                  text: "Активные",
                                  onTap: () {
                                    select.updateTab(1);
                                  },
                                  color: !(select.tab.value == 1)
                                      ? AppColor.WHITE_COLOR
                                      : AppColor.primaryColor,
                                  color1: !(select.tab.value == 1)
                                      ? AppColor.BLACK_COLOR
                                      : AppColor.WHITE_COLOR,
                                ),
                              ),

                              Expanded(
                                child: tabBusinessList(
                                  text: "Архив",
                                  onTap: () {
                                    select.updateTab(2);
                                  },
                                  color: !(select.tab.value == 2)
                                      ? AppColor.WHITE_COLOR
                                      : AppColor.primaryColor,
                                  color1: !(select.tab.value == 2)
                                      ? AppColor.BLACK_COLOR
                                      : AppColor.WHITE_COLOR,
                                ),
                              ),
                            ],
                          ),
                        )
                    ),
                  ),
                );
              }
          ),
          SizedBox(height: Get.height*0.02,),
          Obx(
                  () {
                return




                  Expanded(child: select.tab.value == 0? All():select.tab.value == 1?
                ActiveList():CompleteList(),

                );
              }
          )
        ],
      ),
    );
  }
}
Widget tabBusinessList({text, color, color1, onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration:
      BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: AppText(
          title: text,
          color: color1,
          size: AppSizes.SIZE_13,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}