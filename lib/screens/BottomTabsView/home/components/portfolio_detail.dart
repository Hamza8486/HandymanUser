import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:user_apps/res/colors.dart';

class PortfolioDetail extends StatefulWidget {
  PortfolioDetail({Key? key, this.data}) : super(key: key);
  var data;

  @override
  State<PortfolioDetail> createState() => _PortfolioDetailState();
}

class _PortfolioDetailState extends State<PortfolioDetail> {
  double _scale = 1.0;

  double _previousScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: Get.height * 0.07,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 19),
            child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.clear,
                      size: Get.height * 0.035,
                      color: Colors.white,
                    ))),
          ),
          SizedBox(
            height: Get.height * 0.03,
          ),
          GestureDetector(
            onScaleStart: (ScaleStartDetails details) {
              _previousScale = _scale;
              setState(() {});
            },
            onScaleUpdate: (ScaleUpdateDetails details) {
              setState(() {
                _scale = _previousScale * details.scale;
              });
            },
            onDoubleTap: () {
              setState(() {
                _scale = (_scale == 1.0) ? 2.0 : 1.0;
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
              child: SizedBox(
                height: Get.height * 0.8,
                child: PhotoView(
                  imageProvider: NetworkImage(widget.data.toString()),
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  maxScale: PhotoViewComputedScale.covered * 2,
                  initialScale: PhotoViewComputedScale.contained,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
