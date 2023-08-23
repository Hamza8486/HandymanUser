import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:user_apps/Services/api_manager.dart';
import 'package:user_apps/res/colors.dart';
import 'package:user_apps/screens/BottomTabsView/home/components/portfolio_detail.dart';
import 'package:user_apps/screens/BottomTabsView/home/controllers/home_controller.dart';
import 'package:user_apps/screens/BottomTabsView/my_requests/Component/full_image.dart';
import 'package:user_apps/screens/BottomTabsView/my_requests/Component/provider.dart';
import 'package:user_apps/screens/BottomTabsView/my_requests/Component/reject.dart';
import 'package:user_apps/screens/BottomTabsView/my_requests/Controller/controller.dart';
import 'package:user_apps/screens/bids/model/chat_model.dart';
import 'package:user_apps/widgets/Colors/app_colors.dart';
import 'package:user_apps/widgets/Dialogue/dialogue.dart';
import 'package:user_apps/widgets/Fonts/app_fonts.dart';
import 'package:user_apps/widgets/Loader/loader.dart';
import 'package:user_apps/widgets/app_text.dart';
import 'package:user_apps/widgets/bid_expand.dart';
import '../review/submit_review_screen.dart';
import 'components/provider_action.dart';
import 'controller/chat_provider_controller.dart';

class ChatWithProviderScreen extends StatefulWidget {
  ChatWithProviderScreen({Key? key, this.data, this.postData})
      : super(key: key);

  var data;
  var postData;

  @override
  State<ChatWithProviderScreen> createState() => _ChatWithProviderScreenState();
}

class _ChatWithProviderScreenState extends State<ChatWithProviderScreen> {



  final homeController = Get.put(HomeController());
  final picker = ImagePicker();
  TextEditingController nameController = TextEditingController();

  handleChooseFromGallery() async {
    Navigator.pop(context);
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() async {
      if (image != null) {


        homeController.file1 = File(image.path);
        homeController.updateChatLoading(true);

        ApiManger().sendMessage(context: context,chats:messageController.text );
        homeController.updateScrollLoading(true);
      } else {
        print('No image selected.');
      }
    });
  }

  handleTakePhoto() async {
    Navigator.pop(context);
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);
    setState(() async {
      if (image != null) {
        homeController.file1 = File(image.path);
        print("This is file ${homeController.file1}");
        homeController.updateChatLoading(true);

        ApiManger().sendMessage(context: context,chats:messageController.text );
        homeController.updateScrollLoading(true);

      } else {
        print('No image selected.');
      }
    });
  }

  clearImage() {
    setState(() {});
  }

  selectImage(parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            title: const Text(
              "Выбрать изображение",
            ),
            backgroundColor: Colors.white,
            children: <Widget>[
              SimpleDialogOption(
                child: const Text(
                  "Камера",
                ),
                onPressed: handleTakePhoto,
              ),
              SimpleDialogOption(
                child: const Text("Галерея"),
                onPressed: handleChooseFromGallery,
              ),
              SimpleDialogOption(
                child: const Text("Отмена"),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
  }




  final ChatProviderController chatProviderController =
      Get.put(ChatProviderController());
  TextEditingController messageController = TextEditingController();


  @override
  void initState() {
    super.initState();
    Get.put(HomeController()).updateUserIds(widget.postData.providerId.toString());
    Get.put(HomeController()).chatData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.put(HomeController()).scrollController.animateTo(
        Get.put(HomeController()).scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    });

  }




  bool isScrolled = true;


  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;


    return Scaffold(
      body: Column(
        children: [
          Material(
            color: AppColor.WHITE_COLOR,
            elevation: 1,
            child: SizedBox(
              width: Get.width,
              height: Get.height / 7.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.02,
                        vertical: Get.height * 0.018),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: const Icon(
                                Icons.arrow_back_outlined,
                                color: AppColors.blackColor,
                              )),
                          SizedBox(
                            width: Get.width * 0.02,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(ProviderChat());
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 50.0,
                                  width: 50.0,
                                  child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl:widget.postData.image??"",
                                      fit: BoxFit.cover,
                                      errorWidget:
                                          (context, url, error) =>
                                          ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            child: Image.asset(
                                              'assets/images/person.png',
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                      placeholder: (context, url) =>
                                      const Center(
                                          child:
                                          CircularProgressIndicator(
                                            color: AppColors.blueColor,
                                          )),
                                    ),
                                  ),
                                ),
                                SizedBox(width: Get.width * 0.04),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                        title:
                                        widget.postData.providerName,
                                        size: Get.height * 0.02,
                                        overFlow: TextOverflow.ellipsis,
                                        color: AppColor.DARK_TEXT_COLOR,
                                        fontFamily: Weights.semi),
                                    const SizedBox(height: 4.0),
                                    Row(
                                      children: [
                                        const Text(
                                          'Онлайн',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.green,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),

                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller:Get.put(HomeController()).scrollController,
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  const BidExpand(),
                  const SizedBox(height: 24.0),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: AppColors.greyColor.withOpacity(0.4),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Ink(
                          width: width,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 20.0),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.white,
                                width: 1.5,
                              ),
                            ),
                          ),
                          child: Text(
                            widget.postData.description==null?"Я готов(а) выполнить работу!": widget.postData.description,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: AppColors.blackColor,
                              fontFamily: Weights.medium,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Ink(
                          width: width,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 1.0),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.white,
                                width: 1.5,
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Стоимость :  ',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: AppColors.blackColor,
                                  fontFamily: Weights.medium,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                'от ${widget.postData.price ?? ""} сом',
                                style: TextStyle(
                                  fontSize: 13.0,
                                  color: AppColors.blackColor,
                                  fontFamily: Weights.semi,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),

                  Obx(
                          () {
                        return
                          Get.put(SelectTab()).selectProvider.value=="0"?

                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 24.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: AppColors.greyColor.withOpacity(0.4),
                            ),
                            child: Ink(
                              width: width,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 12.0),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.white,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              child:  Column(
                                children: [
                                  Text(
                                    "Если вы договорились со специалистом, нажмите кнопку",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14.0,

                                      color: AppColors.blackColor,
                                      fontFamily:"Poppins",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),

                                  Text(
                                    "Выбрать специалиста",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16.0,

                                      color: AppColors.blueColor,
                                      fontFamily:"Poppins",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ): Container(
                            margin: const EdgeInsets.symmetric(horizontal: 24.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.yellow.withOpacity(0.3),
                            ),
                            child: Ink(
                              width: width,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 12.0),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.white,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              child:  Column(
                                children: [
                                  Text(
                                    "Специалист выбран. Вы можете отправить детали работы, а после завершения оставить отзыв о специалисте.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 13.0,

                                      color: AppColors.blackColor,
                                      fontFamily:"Poppins",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                      }
                  ),
                  const SizedBox(height: 10.0),
                  Obx(
                          () {
                        return ListView.builder(
                          shrinkWrap: homeController.chatList.isEmpty?true:true,
                          dragStartBehavior: DragStartBehavior.down,
                          itemCount: homeController.chatList.length,
                          reverse: true,
                          primary: false,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15),
                          itemBuilder: (context, index) {
                            // print(jsonEncode(jobController.activeList[index]));
                            // print(jsonEncode(P));

                            return
                              homeController
                                  .chatList[index].messageFromModal ==
                                  "Customer" && homeController
                                  .chatList[index].message=="You was selected for the job."?SizedBox.shrink():

                              Row(
                              mainAxisAlignment: homeController
                                  .chatList[index].messageFromModal ==
                                  "Customer"
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 6),
                                  padding: const EdgeInsets.only(
                                      left: 12,
                                      right: 12,
                                      top: 10,
                                      bottom: 10),
                                  decoration: BoxDecoration(
                                      color: homeController
                                          .chatList[index].messageFromModal ==
                                          "Customer"
                                          ? AppColors.blueColor
                                          : AppColors.greyColor
                                          .withOpacity(.5),
                                      // AppColors.greyColor.withOpacity(.5),
                                      borderRadius: homeController
                                          .chatList[index].messageFromModal ==
                                          "Customer"
                                          ? const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10))
                                          : const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomRight:
                                          Radius.circular(10))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.end,
                                    children: [
                                      homeController
                                          .chatList[index].img != null
                                          ? GestureDetector(
                                        onTap: () {
                                          Get.to(PortfolioDetail(data: homeController
                                              .chatList[index].img,));

                                          /////////  Open image View  imgeUrl: chatList[index]["media"]
                                        },
                                        child: Container(
                                          height: 250,
                                          width: 200,
                                          child: CachedNetworkImage(
                                            imageUrl:
                                            homeController
                                                .chatList[index].img??"",
                                            fit: BoxFit.cover,
                                            placeholder: (context,
                                                url) =>
                                            const Center(
                                                child:
                                                CircularProgressIndicator(
                                                  color: Colors.red,
                                                )),
                                          ),
                                        ),
                                      )
                                          :
                                      Container(
                                        width: homeController
                                            .chatList[index].message.toString().length >27? 200:null,
                                        child: Text(
                                          homeController
                                              .chatList[index].message.toString(),
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            // color: AppColors.blackColor,
                                            color: homeController
                                                .chatList[index].messageFromModal ==
                                                "Customer"
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                            homeController
                                .chatList[index].createdAt.toString(),
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          // color: AppColors.blackColor,
                                          color: homeController
                                              .chatList[index].messageFromModal ==
                                              "Customer"
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                  ),
                   SizedBox(height: Get.height*0.07),
                ],
              ),
            ),
          ),
          Container(
            width: width,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 16.0),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Obx(
                                () {
                              return
                                Get.put(SelectTab()).selectProvider.value=="0"?

                                ProviderAction(
                                  onTap: () {

                                    showAlertDialog(
                                        context: context,
                                        text: "Выбрать специалиста?",
                                        yesOnTap: () {
                                          Get.put(SelectTab()).updateSelectProvider("1");
                                          Get.back();
                                          appLoader(context, AppColors.blueColor);
                                          print(widget.postData.id);
                                          print(widget.data.id);
                                          ApiManger().sendMessage(context: context,chats:"You was selected for the job." );
                                          ApiManger().selectProviderResponse(
                                              post: widget.postData.id.toString(),
                                              id: widget.data.id.toString(),
                                              context: context);
                                        });
                                  },
                                  text: 'Выбрать специалиста',
                                  textColor: Colors.green,
                                  iconData: Icons.check,
                                  iconColor: Colors.green,
                                ):SizedBox.shrink();
                            }
                        ),
                        Obx(
                                () {
                              return
                                Get.put(SelectTab()).selectProvider.value=="0"?SizedBox.shrink():

                                ProviderAction(
                                  onTap: () {
                                    // FirebaseFirestore.instance
                                    //     .collection("Chat_Room")
                                    //     .doc("chat-id-${widget.postData.id}").delete();

                                    Get.to(SubmitReviewScreen(
                                      data: widget.postData,
                                      proId:widget.postData.providerId.toString(),
                                      jobId:widget.postData.jobId.toString(),
                                    ));
                                  },
                                  text: 'Завершить заявку',
                                  textColor: AppColors.blueColor,
                                  iconData: Icons.join_inner_sharp,
                                  iconColor: AppColors.blueColor,
                                  borderColor: AppColors.blueColor,
                                );
                            }
                        ),


                        ProviderAction(
                          onTap: () {
                            Get.to(RejectProvider(jobId:widget.data.id ,postId:widget.postData.id ,),
                                transition: Transition.rightToLeft
                            );

                          },
                          text: 'Отказаться от специалиста',
                          textColor: AppColors.redColor,
                          iconData: Icons.delete,
                          iconColor: AppColors.redColor,
                          borderColor: AppColors.redColor,
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () async{

                          await FlutterPhoneDirectCaller.callNumber(homeController.providerModelData?.phoneNo??"");

                        },
                        child: Container(
                          height: 45.0,
                          width: 45.0,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                          child: const Center(
                            child: Icon(CupertinoIcons.phone_fill,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black.withOpacity(0.5),
                              ),
                              borderRadius: BorderRadius.circular(30)),
                          child: TextFormField(
                            controller: messageController,
                            onChanged: (v) {
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.only(
                                  left: 16.0,top: 15),
                              hintText: 'Ваше сообщение',
                              hintStyle: const TextStyle(
                                fontSize: 14.0,
                                color: AppColors.greyColor,
                                fontWeight: FontWeight.w500,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () => selectImage(context),
                                icon: const Icon(Icons.add,
                                    color: AppColors.greyColor),
                              ),
                            ),

                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Obx(
                        () {
                          return
                            homeController.isChatLoading.value
                                ? Center(
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: AppColor.primaryColor,

                                  ),
                                ))
                                :


                            GestureDetector(
                            onTap: messageController.text.isEmpty
                                ? () {}
                                : () {
                              homeController.updateChatLoading(true);

                              ApiManger().sendMessage(context: context,chats:messageController.text );
                              messageController.clear();

                              setState(() {});

                            },
                            child: Container(
                              height: 45.0,
                              width: 45.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: messageController.text.isNotEmpty
                                    ? Colors.green
                                    : AppColors.greyColor.withOpacity(0.6),
                              ),
                              child: const Center(
                                child: Icon(Icons.send,
                                    color: Colors.white, size: 20.0),
                              ),
                            ),
                          );
                        }
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }

  Widget leadingButton() => GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Container(
          height: 36.0,
          width: 36.0,
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.greyColor.withOpacity(0.5),
          ),
          child: const Center(
            child: Icon(Icons.arrow_back, color: Colors.white, size: 24.0),
          ),
        ),
      );

  Widget menuButton() => GestureDetector(
        onTap: () {},
        child: Container(
          height: 36.0,
          width: 36.0,
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.greyColor.withOpacity(0.5),
          ),
          child: const Center(
            child: Icon(Icons.more_horiz, color: Colors.white, size: 24.0),
          ),
        ),
      );
}
