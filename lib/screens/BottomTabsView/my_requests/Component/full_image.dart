import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_apps/res/colors.dart';

class FullImageView extends StatelessWidget {
   FullImageView({Key? key,this.data}) : super(key: key);
  var data;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(height: Get.height*0.07,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 19),
            child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: Icon(Icons.clear,size: Get.height*0.035,color: Colors.white,))),
          ),
          SizedBox(height: Get.height*0.2,),

          Container(
            margin: EdgeInsets.symmetric(horizontal: Get.width*0.04),
            height: Get.height*0.38,
            width: Get.width,
            child:
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: data , fit: BoxFit.cover,

                placeholder: (context, url) =>


                const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.blueColor,
                    )),



              ),
            ),



          ),
        ],
      ),
    );
  }
}
