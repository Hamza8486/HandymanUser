// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:dio/dio.dart' as dio;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:user_apps/Services/api_constants.dart';
import 'package:user_apps/Services/helper_function.dart';
import 'package:user_apps/screens/Authentication/Login/Model/city_model.dart';
import 'package:user_apps/screens/Authentication/Login/Model/model.dart';
import 'package:user_apps/screens/Authentication/RegisterView/Model/register_model.dart';
import 'package:user_apps/screens/Authentication/RegisterView/register_view.dart';
import 'package:user_apps/screens/BottomTabsView/home/Model/change_address.dart';
import 'package:user_apps/screens/BottomTabsView/home/Model/home_model.dart';
import 'package:user_apps/screens/BottomTabsView/home/Model/popular.dart';
import 'package:user_apps/screens/BottomTabsView/home/Model/search_category.dart';
import 'package:user_apps/screens/BottomTabsView/home/Model/search_sub_category.dart';
import 'package:user_apps/screens/BottomTabsView/home/Model/service_model.dart';
import 'package:user_apps/screens/BottomTabsView/home/Model/sub_model.dart';
import 'package:user_apps/screens/BottomTabsView/home/controllers/home_controller.dart';
import 'package:user_apps/screens/BottomTabsView/my_requests/Model/chats_model.dart';
import 'package:user_apps/screens/BottomTabsView/my_requests/Model/my_request_model.dart';
import 'package:user_apps/screens/BottomTabsView/my_requests/Model/notification.dart';
import 'package:user_apps/screens/BottomTabsView/my_requests/Model/provider_detail.dart';
import 'package:user_apps/screens/BottomTabsView/my_requests/Model/selectProvider.dart';
import 'package:user_apps/screens/BottomTabsView/post_a_job/controllers/post_a_job_controller.dart';
import 'package:user_apps/screens/BottomTabsView/profile/Model/get_profile_model.dart';
import 'package:user_apps/screens/BottomTabsView/support_section/Model/support_model.dart';
import 'package:user_apps/screens/ServicesList/Model/model.dart';
import 'package:user_apps/screens/favorite/Model/faourite_model.dart';
import 'package:user_apps/screens/favorite/Model/model.dart';
import 'package:user_apps/screens/persist_nev_bar.dart';
import 'package:user_apps/screens/provider_list/Model/provider_model.dart';
import 'package:user_apps/widgets/SnackBar/snack_bar.dart';

class ApiManger extends GetConnect {
  var isLoading = false.obs;

  static var client = http.Client();

  static Uri uriPath({required String nameUrl}) {
    print("Url: ${ApiConstants.baseURL}$nameUrl");
    return Uri.parse(ApiConstants.baseURL + nameUrl);
  }

  static Future<LoginResponse?> loginResponse(
      {var phone, required BuildContext context, var token}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> body = <String, dynamic>{};
    body['phone_no'] = phone;
    body['token'] = token;
    var response =
        await client.post(uriPath(nameUrl: ApiConstants.loginURI), body: body);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body.toString());
      print(response.body);
      print(jsonString["data"]["id"]);
      HelperFunctions.saveInPreference(
          "id", jsonString["data"]["id"].toString());
      prefs.setString(
          'id', jsonString["data"]["id"].toString());
      HelperFunctions.saveInPreference(
          "userAddress", jsonString["data"]["address"].toString());
      Get.offAll(HomeScreen(currentIndex: 0));

      return loginResponseFromJson(response.body);
    } else if (response.statusCode == 404) {
      Get.offAll(RegisterView(
        phone: phone,
      ));
      showErrorToast("Создать аккаунт");
      Get.back();
      //show error message
      return null;
    } else {
      Get.back();
      showErrorToast("Ошибка подключения");
      //show error message
      return null;
    }
  }

  // User Register
  static Future<RegisterResponse?> registerResponse(
      {var phone,
      var password,
      var first,
      required BuildContext context,
      var city,
      var token}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> body = <String, dynamic>{};
    body['phone_no'] = phone;
    body['first_name'] = first;
    body['last_name'] = ".";
    body['address'] = city;
    body['token'] = token;
    var response =
        await client.post(uriPath(nameUrl: ApiConstants.register), body: body);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print(response.body);
      print(jsonString["data"]["id"]);
      HelperFunctions.saveInPreference(
          "id", jsonString["data"]["id"].toString());
      prefs.setString(
          'id', jsonString["data"]["id"].toString());
      HelperFunctions.saveInPreference(
          "userAddress", jsonString["data"]["address"].toString());
      Get.offAll(HomeScreen(currentIndex: 0));
      //successToast("Account Created Successfully!");
      successToast("Аккаунт успешно создан!");

      return registerResponseFromJson(response.body);
    } else if (response.statusCode == 404) {
      var jsonString = jsonDecode(response.body);
      Get.back();
      successToast(jsonString['message'].toString());
      //show error message
      return null;
    } else {
      Get.back();
      showErrorToast("Ошибка подключения");
      //show error message
      return null;
    }
  }

// Edit Profile
  editProfile(
      {var userId,
      var name,
      var email,
      var image,
      required BuildContext context}) async {
    try {
      late dio.MultipartFile x, lisenceFile;

      try {
        dio.FormData data = dio.FormData.fromMap({
          'cus_id': userId.toString(),
          'first_name': name,
          'last_name': ".",
          'email': email,
          image == null ? "" : 'profile_image':
              await dio.MultipartFile.fromFile(image == null ? "" : image.path),
        });
        var response = await dio.Dio().post(
          ApiConstants.baseURL + ApiConstants.editProfile,
          data: data,
        );
        print(response);
        print(response.statusCode);
        if (response.statusCode == 200) {
          Get.put(HomeController())
              .profileData(Get.put(HomeController()).userId.value);

          Navigator.pop(context);
          Navigator.pop(context);

          successToast("Профиль обновлен");
        } else {
          Get.back();
        }
      } on dio.DioError catch (e) {
        print(e.response);
        Get.back();
      }
    } on dio.DioError catch (e) {
      print(e.toString());
      Get.back();
    }
  }

  static Future<ProfileResponse?> profileResponse({var id}) async {
    Map<String, dynamic> body = <String, dynamic>{};

    body['cus_id'] = id;

    var response =
        await client.post(uriPath(nameUrl: ApiConstants.profile), body: body);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;

      return profileResponseFromJson(response.body);
    } else {
      print(response.statusCode);

      //show error message
      return null;
    }
  }

  static Future<ProviderListResponse?> providerListResponse({var id}) async {
    Map<String, dynamic> body = <String, dynamic>{};

    body['id'] = id;
    body['customer_id'] = Get.put(HomeController()).userId.value;

    var response = await client.post(uriPath(nameUrl: ApiConstants.allProvider),
        body: body);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;

      return providerListResponseFromJson(response.body);
    } else {
      print(response.statusCode);

      //show error message
      return null;
    }
  }

  Future<SelectProviderResponse?> selectProviderResponse(
      {var id, var post, required BuildContext context}) async {
    Map<String, dynamic> body = <String, dynamic>{};
    final prefs = await SharedPreferences.getInstance();

    body['post_id'] = post;
    body['job_id'] = id;

    var response =
        await client.post(uriPath(nameUrl: ApiConstants.select), body: body);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      Get.put(HomeController())
          .allRequestData(Get.put(HomeController()).userId.value);
      Get.put(HomeController())
          .allRequestData(Get.put(HomeController()).userId.value);
      Get.back();
      successToast("Специалист выбран");

      return selectProviderResponseFromJson(response.body);
    } else if (response.statusCode == 404) {
      var jsonString = jsonDecode(response.body);
      Get.back();
      showErrorToast("${jsonString["message"].toString()}!");

      print(response.statusCode);

      //show error message
      return null;
    }
  }

  static Future<AllRequestResponse?> allRequestResponse({var id}) async {
    Map<String, dynamic> body = <String, dynamic>{};

    body['cus_id'] = id;

    var response = await client
        .post(uriPath(nameUrl: ApiConstants.allRequestResponse), body: body);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print("Hamza");
      print(jsonString.toString());

      return allRequestResponseFromJson(response.body);
    } else {
      print(response.statusCode);

      //show error message
      return null;
    }
  }

  static Future<ProviderDetailModel?> providerDetail({var id}) async {
    Map<String, dynamic> body = <String, dynamic>{};

    body['id'] = id;

    var response = await client
        .post(uriPath(nameUrl: ApiConstants.providerDetail), body: body);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;

      return providerDetailModelFromJson(response.body);
    } else {
      print(response.statusCode);

      //show error message
      return null;
    }
  }

  static Future<FovuriteListResponse?> allFavResponse({var id}) async {
    Map<String, dynamic> body = <String, dynamic>{};

    body['cus_id'] = id;

    var response = await client
        .post(uriPath(nameUrl: ApiConstants.allFavourite), body: body);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;

      return fovuriteListResponseFromJson(response.body);
    } else {
      print(response.statusCode);

      //show error message
      return null;
    }
  }

  static Future<SupportListResponse?> supportResponse() async {
    Map<String, dynamic> body = <String, dynamic>{};

    var response = await client.get(
      uriPath(nameUrl: ApiConstants.support),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;

      return supportListResponseFromJson(response.body);
    } else {
      print(response.statusCode);

      //show error message
      return null;
    }
  }

  static Future<ServiceListResponse?> serviceListResponse() async {
    var response = await client.get(
      uriPath(nameUrl: ApiConstants.serviceList),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;

      return serviceListResponseFromJson(response.body);
    } else {
      print(response.statusCode);

      //show error message
      return null;
    }
  }

  static Future<HomeResponse?> homeResponse() async {
    Map<String, dynamic> body = <String, dynamic>{};

    var response = await client.get(
      uriPath(nameUrl: ApiConstants.homeURI),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;

      return homeResponseFromJson(response.body);
    } else {
      print(response.statusCode);

      //show error message
      return null;
    }
  }

  static Future<CityResponse?> cityResponse() async {
    Map<String, dynamic> body = <String, dynamic>{};

    var response = await client.get(
      uriPath(nameUrl: ApiConstants.city),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;

      return cityResponseFromJson(response.body);
    } else {
      print(response.statusCode);

      //show error message
      return null;
    }
  }

  static Future<SearchCategoryModel?> searchCategoryRes({var category}) async {
    Map<String, dynamic> body = <String, dynamic>{};
    body['search'] = category;

    var response =
        await client.post(uriPath(nameUrl: ApiConstants.searchCat), body: body);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print(response.body);

      return searchCategoryModelFromJson(response.body);
    } else {
      return null;
    }
  }

  static Future<SubCatModel?> subCategoryRes({var category}) async {
    Map<String, dynamic> body = <String, dynamic>{};
    body['search'] = category;

    var response = await client
        .post(uriPath(nameUrl: ApiConstants.searchSubCat), body: body);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print(response.body);

      return SubCatModel.fromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future<PopularSubModel?> popularRes() async {
    var response = await client.get(uriPath(nameUrl: ApiConstants.popular));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print(response.body);

      return popularSubModelFromJson(response.body);
    } else {
      return null;
    }
  }

  static Future<ServiceSubModel?> subCatRes({var category}) async {
    Map<String, dynamic> body = <String, dynamic>{};
    body['cat_id'] = category;

    var response =
        await client.post(uriPath(nameUrl: ApiConstants.subCat), body: body);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print(response.body);

      return serviceSubModelFromJson(response.body);
    } else {
      return null;
    }
  }

//Post Job Provider

  updateJobProvider(
      {var jobId,
      var id,
      var desc,
      var address,
      var budget,
      var image,
      required BuildContext context,
      var phone}) async {
    try {
      late dio.MultipartFile x, lisenceFile;

      try {
        dio.FormData data = dio.FormData.fromMap({
          'job_id': jobId,
          'cus_id': id,
          'description': desc,
          'address': address,
          'budget': budget,
          'date': Get.put(PostAJobController()).selectDate.value,
          'phone_no': phone,
          image == null ? "" : 'post_image':
              image == null ? "" : await dio.MultipartFile.fromFile(image.path),
        });
        var response = await dio.Dio().post(
          ApiConstants.baseURL + ApiConstants.editJobProvider,
          data: data,
        );
        print(response);
        print(response.statusCode);
        if (response.statusCode == 200) {
          Get.put(HomeController())
              .allRequestData(Get.put(HomeController()).userId.value);

          Get.offAll(HomeScreen(currentIndex: 1));
          Get.back();
          successToast("Заявка обновлена");
        } else {
          Get.back();
        }
      } on dio.DioError catch (e) {
        print(e.response);
        Get.back();
      }
    } on dio.DioError catch (e) {
      print(e.toString());
      Get.back();
    }
  }

  delJobProvider({
    var jobId,
    required BuildContext context,
  }) async {
    try {
      late dio.MultipartFile x, lisenceFile;

      try {
        dio.FormData data = dio.FormData.fromMap({
          'job_id': jobId,
        });
        var response = await dio.Dio().post(
          ApiConstants.baseURL + ApiConstants.delJob,
          data: data,
        );
        print(response);
        print(response.statusCode);
        if (response.statusCode == 200) {
          Get.put(HomeController()).homeData();
          Get.put(HomeController()).homeData1();
          Get.put(HomeController()).allPopularData();
          Get.put(HomeController()).profileData(Get.put(HomeController()).userId.value);
          Get.put(HomeController())
              .allRequestData(Get.put(HomeController()).userId.value);

          Get.offAll(HomeScreen(currentIndex: 0));
          Get.back();
          successToast("Заявка успешно удалена");
        } else {
          Get.back();
        }
      } on dio.DioError catch (e) {
        print(e.response);
        Get.back();
      }
    } on dio.DioError catch (e) {
      print(e.toString());
      Get.back();
    }
  }

  postJobAll({required BuildContext context, provider = "", sub = ""}) async {
    try {
      late dio.MultipartFile x, lisenceFile;

      try {
        dio.FormData data = dio.FormData.fromMap({
          'cus_id': Get.put(HomeController()).userId.value,
          'service_id': sub.toString(),
          'description': Get.put(HomeController()).descriptionController.text,
          'address': Get.put(PostAJobController()).addressController.text,
          'budget': Get.put(HomeController()).budgetController.text,
          'date': Get.put(PostAJobController()).selectDate.value,
          'provider_id': provider.toString(),
          'phone_no': Get.put(HomeController()).profileMOdel?.phoneNo ?? "",
          'post_image': Get.put(HomeController()).file == null
              ? ""
              : await dio.MultipartFile.fromFile(
                  Get.put(HomeController()).file!.path),
        });
        var response = await dio.Dio().post(
          ApiConstants.baseURL + ApiConstants.postAllProvider,
          data: data,
        );
        print(response);
        print(response.statusCode);
        if (response.statusCode == 200) {
          Get.put(HomeController())
              .allRequestData(Get.put(HomeController()).userId.value);


          Get.offAll(HomeScreen(currentIndex: 1));
          Get.put(HomeController())
              .allRequestData(Get.put(HomeController()).userId.value);
          Get.put(HomeController()).updateSubId("");
          Get.put(HomeController()).updateProvider("");
          Get.put(HomeController()).clearController();


          successToast("Заявка создана успешно");
        } else {
          showErrorToast("Ошибка, повторите попытку");
          Get.back();
        }
      } on dio.DioError catch (e) {
        showErrorToast("SomeThing Went Wrong");
        print(e.response);
        Get.back();
      }
    } on dio.DioError catch (e) {
      print(e.toString());
      Get.back();
    }
  }

  static Future<FavouriteResponse?> favResponse(
      {var id,
      var providerId,
      var status,
      required BuildContext context}) async {
    Map<String, dynamic> body = <String, dynamic>{};

    body['cus_id'] = id;
    body['provider_id'] = providerId;
    body['status'] = status;

    var response =
        await client.post(uriPath(nameUrl: ApiConstants.favourite), body: body);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      Get.put(HomeController())
          .allFavData(Get.put(HomeController()).userId.value);
      var jsonString = jsonDecode(response.body);

      successToast("Добавлено в избранное");

      return favouriteResponseFromJson(jsonString);
    } else if (response.statusCode == 400) {
      showErrorToast("Уже добавлено в избранное");
      print(response.statusCode);

      //show error message
      return null;
    }
  }

  Future<FavouriteResponse?> removeResponse(
      {var id,
      var providerId,
      var status,
      required BuildContext context}) async {
    Map<String, dynamic> body = <String, dynamic>{};

    body['cus_id'] = id;
    body['provider_id'] = providerId;
    body['status'] = status;

    var response =
        await client.post(uriPath(nameUrl: ApiConstants.favourite), body: body);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      Get.back();
      Get.put(HomeController()).allFavList.clear();
      Get.put(HomeController())
          .allFavData(Get.put(HomeController()).userId.value);
      Get.put(HomeController())
          .profileData(Get.put(HomeController()).userId.value);

      showErrorToast("Избранное удалено");

      return favouriteResponseFromJson(response.body);
    } else if (response.statusCode == 400) {
      Get.back();
      showErrorToast("No Items Remaining");
      print(response.statusCode);

      //show error message
      return null;
    }
  }

  Future<FavouriteResponse?> removeResponse1(
      {var id,
      var providerId,
      var status,
      required BuildContext context}) async {
    Map<String, dynamic> body = <String, dynamic>{};

    body['cus_id'] = id;
    body['provider_id'] = providerId;
    body['status'] = status;

    var response =
        await client.post(uriPath(nameUrl: ApiConstants.favourite), body: body);

    if (response.statusCode == 200) {
      Get.put(HomeController())
          .allFavData(Get.put(HomeController()).userId.value);
      print("Hamxaa");
      print(response.statusCode);
      print(response.body);

      successToast("Удалить избранное");

      return favouriteResponseFromJson(response.body);
    } else if (response.statusCode == 400) {
      Get.back();
      showErrorToast("No Items Remaining");
      print(response.statusCode);

      //show error message
      return null;
    }
  }

  Future<ChangeAddressResponse?> changeAddressResponse(
      {var address, required BuildContext context}) async {
    Map<String, dynamic> body = <String, dynamic>{};

    body['cus_id'] = Get.put(HomeController()).userId.value;
    body['city_id'] = address;

    var response = await client
        .post(uriPath(nameUrl: ApiConstants.addressChange), body: body);

    Get.put(HomeController())
        .profileData(Get.put(HomeController()).userId.value);
    if (response.statusCode == 200) {
      print(response.body);

      var jsonString = jsonDecode(response.body);
      Get.put(HomeController())
          .profileData(Get.put(HomeController()).userId.value);
      HelperFunctions.saveInPreference(
          "userAddress", jsonString['data']['address'].toString());
      Get.put(HomeController())
          .updateAddress(jsonString['data']['address'].toString());
      Get.back();
      Get.back();

      Get.put(HomeController()).homeData();
      Get.put(HomeController()).homeData1();
      Get.put(HomeController()).allPopularData();

      Get.put(HomeController())
          .profileData(Get.put(HomeController()).userId.value);
      successToast(jsonString['message'].toString());

      return changeAddressResponseFromJson(response.body);
    } else if (response.statusCode == 400) {
      var jsonString = jsonDecode(response.body);
      Get.back();
      showErrorToast(jsonString['error']['message'].toString());
      print(response.statusCode);

      //show error message
      return null;
    }
  }

  rejectProvider({id, postId, context}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'post_id': postId.toString(),
        'job_id': id.toString(),
        'reason': Get.put(HomeController()).selectValue.value,
      });
      print(data);
      var response = await dio.Dio().post(
        ApiConstants.baseURL + ApiConstants.reject,
        data: data,
      );
      print(data);
      print(response);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Get.put(HomeController()).homeData();
        Get.put(HomeController()).homeData1();
        Get.put(HomeController()).allPopularData();
        Get.put(HomeController()).profileData(Get.put(HomeController()).userId.value);
        Get.put(HomeController())
            .allRequestData(Get.put(HomeController()).userId.value);


        Get.offAll(HomeScreen(currentIndex: 0));
        Get.back();
       // successToast("Thanks for using service !");
        Get.put(HomeController()).updateSelectValue("");
        successToast("Специалист отклонен");
      } else {}
    } on dio.DioError catch (e) {
      Get.back();
      showErrorToast(e.response.toString());
      print(e.response);
    }
  }

  leaveReview({desc, Id, price, rating, context, job}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'description': desc,
        'customer_id': Get.put(HomeController()).userId.value,
        'provider_id': Id,
        'job_id': job,
        'rating': rating,
        'price': price,
      });
      var response = await dio.Dio().post(
        ApiConstants.baseURL + ApiConstants.userReview,
        data: data,
      );
      print(response);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Get.put(HomeController()).homeData();
        Get.put(HomeController()).homeData1();
        Get.put(HomeController()).allPopularData();
        Get.put(HomeController()).profileData(Get.put(HomeController()).userId.value);
        Get.put(HomeController())
            .allRequestData(Get.put(HomeController()).userId.value);


        Get.offAll(HomeScreen(currentIndex: 0));
        Get.back();
        successToast("Спасибо за использование сервиса!");
      } else {
        Get.back();
      }
    } on dio.DioError catch (e) {
      Get.back();
      showErrorToast(e.response!.data.toString());
      print(e.response);
    }
  }

  sendNotif({desc, Id}) async {
    try {
      dio.FormData data = dio.FormData.fromMap({
        'pro_id': Id,
        'message': desc,
      });
      var response = await dio.Dio().post(
        ApiConstants.baseURL + ApiConstants.notif,
        data: data,
      );
      print(response);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("this  is the message ${response.data}");
        print(response.data);
      } else {}
    } on dio.DioError catch (e) {
      print(e.response);
    }
  }

  static Future<ServicesModel?> servicesResponse({id = "", sub = ""}) async {
    Map<String, dynamic> body = <String, dynamic>{};

    //body['search'] = id;
    body['sub_cat_id'] = sub.toString();

    var response =
        await client.post(uriPath(nameUrl: ApiConstants.services), body: body);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;

      return servicesModelFromJson(jsonString);
    } else {
      print(response.statusCode);

      //show error message
      return null;
    }
  }

  static Future<GetProviderChatModel?> getChatListaLL() async {
    Map<String, dynamic> body = <String, dynamic>{};

    body['pro_id'] = Get.put(HomeController()).userIds.value;
    body['cus_id'] = Get.put(HomeController()).userId.value;
    body['job_id'] = Get.put(HomeController()).jobIds.value;
    print(body);

    var response =
    await client.post(uriPath(nameUrl: ApiConstants.CHAT), body: body);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      Get.put(HomeController()).scrollToLastMessage();

      return getProviderChatModelFromJson(jsonString);
    } else {
      print(response.statusCode);

      //show error message
      return null;
    }
  }




  sendMessage({required BuildContext context,chats}) async {
    try {
      late dio.MultipartFile x, lisenceFile;

      try {
        dio.FormData data = dio.FormData.fromMap({
          'pro_id':Get.put(HomeController()).userIds.value,
          'cus_id': Get.put(HomeController()).userId.value,
          'job_id': Get.put(HomeController()).jobIds.value,
          'message': chats.toString(),
          'phone_no': Get.put(HomeController()).profileMOdel?.phoneNo ?? "",
          Get.put(HomeController()).file1==null?"":
          'file': Get.put(HomeController()).file1 == null
              ? ""
              : await dio.MultipartFile.fromFile(
              Get.put(HomeController()).file1!.path),
        });
        var response = await dio.Dio().post(
          ApiConstants.baseURL + ApiConstants.SEND,
          data: data,
        );
        print(data.fields);
        print(response);
        print(response.statusCode);
        if (response.statusCode == 200) {
          Get.put(HomeController()).chatData();

          Get.put(HomeController()).file1=null;
          Get.put(HomeController()).updateScrollLoading(true);
          Get.put(HomeController()).updateChatLoading(false);
        }
      } on dio.DioError catch (e) {
        Get.put(HomeController()).updateChatLoading(false);
        Get.put(HomeController()).file1=null;
        showErrorToast("${e.response?.data["message"]}");

        debugPrint("e.response");
        debugPrint(e.response.toString());
      }
    } on dio.DioError catch (e) {
      Get.put(HomeController()).updateChatLoading(false);
      Get.put(HomeController()).file1=null;
      showErrorToast("${e.response?.data["message"]}");

      debugPrint("e.response");
      debugPrint(e.response.toString());
    }
  }




  static Future<GetNotificationAll?> getNotificationAll() async {

    var response = await client.get(
      uriPath(nameUrl: "${ApiConstants.noti}${Get.put(HomeController()).userId.value}"),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);

      return GetNotificationAll.fromJson(jsonString);
    } else {
      print(response.statusCode);

      //show error message
      return null;
    }
  }


  getAllNoti({job}) async {
    try {
      var response = await dio.Dio().get(
        "${ApiConstants.baseURL + ApiConstants.getAll}${job.toString()}",
      );
      print(response);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("Hamza");
        print(response.data);
       Get.put(HomeController()).notData();
        print(response.data);
      } else {}
    } on dio.DioError catch (e) {
      print(e.response);
    }
  }
}
