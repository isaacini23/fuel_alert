import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fuel_alert/core/local-storage/local-storage.dart';
import 'package:fuel_alert/core/routes/app/app-route-names.dart';
import 'package:fuel_alert/services/notification/notification-api-services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../services/authentication/authentication-services.dart';

class AuthStateController extends GetxController {
  // INSTANT VARIABLES
  String _email = "";
  String _password = "";
  String _phone = "";
  String _passwordConfirm = "";
  String _currentPassword = "";
  String _code = "";
  bool _showPassword = false;
  bool _isLoading = false;
  bool _isRemembered = false;
  FirebaseAuth _auth = FirebaseAuth.instance;

  // GETTERS
  String get email => _email;
  String get password => _password;
  String get phone => _phone;
  String get passwordConfirm => _passwordConfirm;
  String get currentPassword => _currentPassword;
  String get code => _code;
  bool get isLoading => _isLoading;
  bool get showPassword => _showPassword;
  bool get isRemembered => _isRemembered;

  // SETTERS
  updateEmail(value) {
    _email = value;
    update();
  }

  updatePassword(value) {
    _password = value;
    update();
  }

  updatePhone(value) {
    _phone = value;
    update();
  }

  updatePasswordConfirm(value) {
    _passwordConfirm = value;
    update();
  }

  updateCurrentPassword(value) {
    _currentPassword = value;
    update();
  }

  updateCode(value) {
    _code = value;
    update();
  }

  toggleShowPassword() {
    _showPassword = !_showPassword;
    update();
  }

  toggleIsRemembered() {
    _isRemembered = !_isRemembered;
    update();
  }

  updateIsLoading(value) {
    _isLoading = value;
    update();
  }

  // FORMAT EMAIL
  String formatEmail(String email) {
    // Split the email into two parts: username and domain
    List<String> parts = email.split("@");

    // Check if the email has exactly two parts
    if (parts.length != 2) {
      // Invalid email format, return the original email
      return email;
    }

    String username = parts[0];
    String domain = parts[1];

    // Ensure at least 4 characters of the username are visible
    int visibleLength = 4;
    if (username.length <= visibleLength) {
      // If the username is shorter than or equal to the visible length, show it as is
      return email;
    }

    // Replace characters in the username except the first few with asterisks
    String obscuredUsername = username.substring(0, visibleLength) +
        '*' * (username.length - visibleLength);

    // Combine the obscured username and domain to form the final email
    String formattedEmail = "$obscuredUsername@$domain";

    return formattedEmail;
  }

  // API CALLS
  Future login() async {
    updateIsLoading(true);

    var data = {"email": _email, "password": _password};

    var response = await AuthServices().loginService(data);
    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      updateIsLoading(false);

      await LocalStorage().storeUserToken(responseData['data']['token']);

      getFcmToken();

      Get.offAllNamed(dashboard);

    } else {
      updateIsLoading(false);
      Get.snackbar("Failed", responseData["message"] ?? responseData["detail"],
          colorText: Colors.white, backgroundColor: const Color(0xffFF0000));
    }
  }

  Future register() async {
    updateIsLoading(true);

    var data = {
      "email": _email,
      "password": _password,
    };

    log(data.toString());

    var response = await AuthServices().registerService(data);
    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      updateIsLoading(false);

      Get.toNamed(verifyEmailScreen);
    } else {
      updateIsLoading(false);
      Get.snackbar("Failed", responseData["message"] ?? responseData["detail"],
          colorText: Colors.white, backgroundColor: const Color(0xffFF0000));
    }
  }

  Future verifyEmail() async {
    updateIsLoading(true);

    var data = {"email": _email, "otp": _code};

    log(data.toString());

    var response = await AuthServices().verifyEmailCodeService(data);
    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      updateIsLoading(false);

      Get.offAllNamed(signInScreen);
    } else {
      updateIsLoading(false);
      Get.snackbar("Failed", responseData["message"] ?? responseData["detail"],
          colorText: Colors.white, backgroundColor: const Color(0xffFF0000));
    }
  }

  Future resendEmailCode() async {
    updateIsLoading(true);

    var data = {"email": _email};

    log(data.toString());

    var response = await AuthServices().resendEmailService(data);
    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      updateIsLoading(false);

      Get.snackbar("Success", responseData["message"] ?? responseData["detail"],
          colorText: Colors.white, backgroundColor: Colors.green);
    } else {
      updateIsLoading(false);
      Get.snackbar("Failed", responseData["message"] ?? responseData["detail"],
          colorText: Colors.white, backgroundColor: const Color(0xffFF0000));
    }
  }

  Future forgotPassword() async {
    updateIsLoading(true);

    var data = {
      "email": _email,
    };

    var response = await AuthServices().forgotPasswordService(data);
    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      updateIsLoading(false);

      Get.toNamed(verifyPasswordScreen);
    } else {
      updateIsLoading(false);
      Get.snackbar("Failed", responseData["message"] ?? responseData["detail"],
          colorText: Colors.white, backgroundColor: const Color(0xffFF0000));
    }
  }

  Future resetPassword() async {
    updateIsLoading(true);

    var data = {"email": _email, "token": _code, "newPassword": _password};

    log(data.toString());

    var response = await AuthServices().resetPasswordService(data);
    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      updateIsLoading(false);

      Get.offAllNamed(signInScreen);
    } else {
      updateIsLoading(false);
      Get.snackbar("Failed", responseData["message"] ?? responseData["detail"],
          colorText: Colors.white, backgroundColor: const Color(0xffFF0000));
    }
  }

  Future<void> appleSocialAuth(code) async {
    updateIsLoading(true);

    var data = {"authorizationCode": code};

    var response = await AuthServices().appleAuthLoginService(data);
    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      updateIsLoading(false);

      await LocalStorage().storeUserToken(responseData["data"]["token"]);

      Get.offAllNamed(dashboard);
    } else {
      updateIsLoading(false);

      Get.snackbar("Failed", responseData["message"] ?? responseData["title"],
          colorText: Colors.white, backgroundColor: Colors.red);
    }
  }

  Future<void> googleSocialAuth(token) async {
    updateIsLoading(true);

    var data = {"idToken": token};

    var response = await AuthServices().googleAuthLoginService(data);
    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      updateIsLoading(false);

      await LocalStorage().storeUserToken(responseData["data"]["token"]);

      Get.offAllNamed(dashboard);
    } else {
      updateIsLoading(false);

      Get.snackbar("Failed", responseData["message"] ?? responseData["title"],
          colorText: Colors.white, backgroundColor: Colors.red);
    }
  }

  Future googleAuth(context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn(
              clientId: (Platform.isIOS)
                  ? "1062300222428-id7plijl9ua9b8rn5mj55mqpg7ia03s3.apps.googleusercontent.com"
                  : "1062300222428-btpo2bq0jm6rfpq2pcm19rbd7pj1nv2m.apps.googleusercontent.com")
          .signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      log(credential.idToken.toString());

      googleSocialAuth(credential.idToken);

      await _auth.signInWithCredential(credential);
    } on PlatformException catch (e) {
      if (e.code == GoogleSignIn.kNetworkError) {
        String errorMessage =
            "A network error (such as timeout, interrupted connection or unreachable host) has occurred.";
        Get.snackbar("Failed", errorMessage,
            colorText: Colors.white, backgroundColor: Colors.red);
      } else {
        log(e.toString());
        Get.snackbar("Failed", e.toString(),
            colorText: Colors.white, backgroundColor: Colors.red);
      }
    }
  }

  Future<void> appleAuth(context) async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
          webAuthenticationOptions: WebAuthenticationOptions(
              clientId: "com.dekon.fuelalert.app",
              redirectUri: Uri.parse("https://api.fuelalertng.com")));

      log(credential.toString());

      appleSocialAuth(credential.authorizationCode);
    } on SignInWithAppleAuthorizationException catch (e) {
      Get.snackbar("Failed", e.message.toString(),
          colorText: Colors.white, backgroundColor: Colors.red);
    }
  }

  Future<void> triggerGoogle(context) async {
    try {
      // updateIsLoading(true);

      await googleAuth(context);

      // updateIsLoading(false);
    } catch (e) {
      // updateIsLoading(false);

      GoogleSignIn().signOut();

      log(e.toString());
    }
  }

  Future<void> triggerAppleAuth(context) async {
    try {
      await appleAuth(context);
    } catch (e) {
      log(e.toString());
    }
  }

  Future enableNotifications({token}) async {
    var data = {
      "token": token,
    };

    var response =
        await NotificationApiServices().enableNotificationsServices(data);
    var responseData = response!.data;
    log("FCM RESPONSE::::$responseData");

    if (response.statusCode == 200 || response.statusCode == 201) {
    } else {}
  }

  Future disableNotifications() async {
    String token = await LocalStorage().fetchFCMToken();

    var data = {
      "token": token,
    };

    log("DATA::::$data");

    var response =
        await NotificationApiServices().disableNotificationServices(data);
    var responseData = response!.data;
    log("FCM RESPONSE::::$responseData");

    if (response.statusCode == 200 || response.statusCode == 201) {
    } else {}
  }

  Future<void> getFcmToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    String? token = (Platform.isAndroid)?
    await messaging.getToken():
    (kDebugMode ?
    await messaging.getAPNSToken():
    await messaging.getToken());
    log('FCM TOKEN: $token');

    await LocalStorage().storeFCMToken(token ?? '');
    enableNotifications(token: token);


  }

}
