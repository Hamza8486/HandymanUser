// ignore_for_file: must_be_immutable


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:user_apps/res/colors.dart';
import 'package:user_apps/screens/BottomTabsView/home/controllers/home_controller.dart';
import 'package:user_apps/screens/BottomTabsView/home/home_screen.dart';
import 'package:user_apps/screens/BottomTabsView/my_requests/View/request_view.dart';
import 'package:user_apps/screens/BottomTabsView/post_a_job/post_a_job_screen.dart';
import 'package:user_apps/screens/BottomTabsView/profile/profile_screen.dart';
import 'package:user_apps/screens/BottomTabsView/support_section/support_section_screen.dart';
import 'package:user_apps/widgets/Colors/app_colors.dart';




class HomeScreen extends StatefulWidget {
  late int currentIndex;
  var value;
  var data;

  HomeScreen({Key? key, required this.currentIndex,this.value,this.data}) : super(key: key);


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var homeController = Get.put(HomeController());





  final List _screens = [
    Dashboard(),
    RequestView(),
    PostJobScreen(),
    SupportSectionScreen(),
    ProfileScreen(),
  ];



  void _selectedPage(int index) {
    setState(() {
      widget.currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async{
        if(widget.currentIndex==0){
          return true;
        }
        setState(() {
          widget.currentIndex=0;
        });
        return false;

      },
      child: Stack(
        children: [
          Scaffold(
              bottomNavigationBar: Container(
                height: 70.0,
                child: BottomNavigationBar(
                  backgroundColor: Colors.white,
                  selectedItemColor: AppColor.primaryColor,
                  selectedLabelStyle: TextStyle(color: AppColor.primaryColor,),
                  unselectedItemColor: AppColors.greyColor,
                  onTap: _selectedPage,
                  currentIndex: widget.currentIndex,
                  type: BottomNavigationBarType.fixed,
                  items: [
                    const BottomNavigationBarItem(
                      activeIcon: Icon(Icons.home),
                      icon: Icon(Icons.home),
                      label: "Главная",
                      tooltip: "Home",
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.bookmark),
                      activeIcon: Icon(Icons.bookmark),
                      label: "Заказы",
                      tooltip: "Requests",
                    ),
                    BottomNavigationBarItem(
                      icon: const Icon(Icons.add_circle, color: Colors.green),


                      /*Badge(
                        toAnimate: false,
                        badgeContent: const Text("",
                          style: TextStyle(
                            fontSize: 7.0,
                            color: Colors.white,
                          ),
                        ),
                        elevation: 0.0,
                        badgeColor: Colors.transparent,
                        child:
                      ),*/
                      label: "Создать",
                      tooltip: "Post a Job",
                    ),
                    BottomNavigationBarItem(
                      icon: const Icon(Icons.contact_support_rounded),

                      label: "Помощь",
                      tooltip: "Support",
                    ),
                    BottomNavigationBarItem(
                      icon: const Icon(Icons.person),

                      label: "Профиль",
                      tooltip: "Profile",
                    ),
                  ],
                ),
              ),
              body: _screens[widget.currentIndex],
            ),
          Obx(
            () {
              return
                Get.put(HomeController()).notificationList.where((p0) =>p0.isRead==null).isNotEmpty?
                Positioned(
                  bottom: Get.height*0.055,
                  left: Get.width*0.305,
                  child: Container(
                    height: 10.0,
                    width: 10.0,
                decoration: BoxDecoration(color: Colors.red,
                borderRadius: BorderRadius.circular(40)
                ),
              )):Positioned(
                    bottom: Get.height*0.055,
                    left: Get.width*0.305,
                    child: SizedBox.shrink());
            }
          )
        ],
      ),
    );

  }
}
