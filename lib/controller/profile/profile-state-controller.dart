import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fuel_alert/core/local-storage/local-storage.dart';
import 'package:fuel_alert/core/routes/app/app-route-names.dart';
import 'package:fuel_alert/services/notification/notification-api-services.dart';
import 'package:fuel_alert/services/profile/profile-services.dart';
import 'package:get/get.dart';

import '../../models/user-model.dart';

class ProfileStateController extends GetxController {
  // INSTANT VARIABLES
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  bool _isLoading = false;
  User _user = User();
  final List<String> _genders = [
    "Male",
    "Female",
  ];
  String _oldPassword = "";
  String _newPassword = "";
  String _confirmPassword = "";

  // GETTERS
  TextEditingController get fullName => _fullNameController;
  TextEditingController get email => _emailController;
  TextEditingController get gender => _genderController;
  TextEditingController get phone => _phoneController;
  TextEditingController get username => _userNameController;
  TextEditingController get addresss => _addressController;
  List get genders => _genders;
  bool get isLoading => _isLoading;
  User get user => _user;
  String get oldPassword => _oldPassword;
  String get newPassword => _newPassword;
  String get confirmPassword => _confirmPassword;

  // SETTERS
  updateIsLoading(value) {
    _isLoading = value;
    update();
  }

  updateSelectedGender(value) {
    _genderController.text = value;
    update();
  }

  updateOldPassword(value) {
    _oldPassword = value;
    update();
  }

  updateConfirmPassword(value) {
    _confirmPassword = value;
    update();
  }

  updateNewPassword(value) {
    _newPassword = value;
    update();
  }

  // API CALLS
  Future getProfile(context) async {
    // updateIsLoading(true);

    var response = await ProfileServices().getProfileService();
    var responseData = response!.data;
    log(responseData.toString());
    String authToken = await LocalStorage().fetchUserToken();

    if (response.statusCode == 200 || response.statusCode == 201) {
      // updateIsLoading(false);

      _user = User.fromMap(responseData["data"]);
      _emailController.text = responseData["data"]["email"];
      _fullNameController.text = "${responseData["data"]["fullName"]}";
      _userNameController.text = "${responseData["data"]["userName"] ?? ""}";
      _genderController.text = "${responseData["data"]["gender"] ?? ""}";
      _phoneController.text = "${responseData["data"]["phoneNumber"] ?? ""}";
      _addressController.text = "${responseData["data"]["address"] ?? ""}";
    } 
    else if (response.statusCode == 401) {
      if(authToken.isEmpty) {
        null;
      }else {
        await LocalStorage().deleteUserToken();
        Get.offAllNamed(signInScreen);
      }
    } 
    else {}

    update();
  }

  Future updateProfile(context) async {
    updateIsLoading(true);

    var data = {
      "firstName": _fullNameController.text.toString().split(" ").first,
      "lastName": _fullNameController.text.toString().split(" ").last,
      "phoneNumber": _phoneController.text,
      "username": _userNameController.text,
      "gender": _genderController.text,
      "address": _addressController.text
    };

    log(data.toString());

    var response = await ProfileServices().updateProfileService(data);
    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      updateIsLoading(false);

      // _user = User.fromMap(responseData["data"]);
      // _emailController.text = responseData["data"]["email"];
      // _fullNameController.text = "${responseData["data"]["name"]}";
      // _userNameController.text = "${responseData["data"]["username"] ?? ""}";
      // _genderController.text = "${responseData["data"]["gender"]}";
      // _phoneController.text = "${responseData["data"]["phone"] ?? ""}";

      Get.back();

      Get.snackbar("Success", responseData["message"],
          colorText: Colors.white, backgroundColor: Colors.green);
    } else {
      updateIsLoading(false);

      Get.snackbar("Failed", responseData["message"],
          colorText: Colors.white, backgroundColor: Colors.red);
    }

    update();
  }

  Future changePassword() async {
    updateIsLoading(true);

    var data = {
      "oldPassword": _oldPassword,
      "newPassword": _newPassword,
      "confirmPassword": _confirmPassword
    };

    var response = await ProfileServices().changePasswordService(data);
    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      updateIsLoading(false);

      Get.snackbar("Success", responseData["message"] ?? responseData["detail"],
          colorText: Colors.white, backgroundColor: Colors.green);

      Get.back();
    } else {
      updateIsLoading(false);
      Get.snackbar("Failed", responseData["message"] ?? responseData["detail"],
          colorText: Colors.white, backgroundColor: const Color(0xffFF0000));
    }
  }

  Future deleteAccount() async {
    updateIsLoading(true);

    var response = await ProfileServices().deleteAccountService();
    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      updateIsLoading(false);

      Get.snackbar("Success", responseData["message"] ?? responseData["detail"],
          colorText: Colors.white, backgroundColor: Colors.green);

      Get.offAllNamed(signInScreen);
      
    } else {
      updateIsLoading(false);
      Get.snackbar("Failed", responseData["message"] ?? responseData["detail"],
          colorText: Colors.white, backgroundColor: const Color(0xffFF0000));
    }
  }

  Future enableNotifications({userId, token}) async {
    var data = {
      "userId": userId,
      "token": token,
    };

    var response =
        await NotificationApiServices().enableNotificationsServices(data);
    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
    } else {}
  }

  Future disableNotifications() async {
    String token = await LocalStorage().fetchFCMToken();

    var data = {
      "token": token,
    };

    var response =
        await NotificationApiServices().disableNotificationServices(data);
    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
    } else {}
  }

  Future<void> getFcmToken({userId}) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    String? token = await messaging.getToken();
    log('FCM TOKEN: $token');

    if (token!.isNotEmpty) {
      await LocalStorage().storeFCMToken(token);
      enableNotifications(userId: userId, token: token);
    } else {
      null;
    }
  }


}
