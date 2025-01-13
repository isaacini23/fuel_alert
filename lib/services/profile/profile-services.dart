import 'dart:developer';
import 'package:dio/dio.dart';

import '../../core/local-storage/local-storage.dart';
import '../../core/routes/api/api-routes.dart';

class ProfileServices {
  final Dio _dio = Dio();

  // GET PROFILE
  Future<Response?> getProfileService() async {
    try {
      String url = "$baseUrl$getProfile";
      String token = await LocalStorage().fetchUserToken();
      var response = await _dio.get(url,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          }));
      return response;
    } catch (error) {
      if (error is DioException) {
        log("$error");
        return error.response;
      } else {
        throw Exception(error);
      }
    }
  }

  // UPDATE PROFILE
  Future<Response?> updateProfileService(data) async {
    try {
      String url = "$baseUrl$updateProfile";
      String token = await LocalStorage().fetchUserToken();

      log(data.toString());

      var response = await _dio.put(url,
          data: data,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          }));
      return response;
    } catch (error) {
      if (error is DioException) {
        log("$error");
        return error.response;
      } else {
        throw Exception(error);
      }
    }
  }

  // DELETE USER ACCOUNT
  Future<Response?> deleteAccountService() async {
    try {
      String url = "$baseUrl$deleteUser/";
      String token = await LocalStorage().fetchUserToken();

      var response = await _dio.delete(url,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          }));
      return response;
    } catch (error) {
      if (error is DioException) {
        log("$error");
        return error.response;
      } else {
        throw Exception(error);
      }
    }
  }

  // CHANGE PASSWORD SERVICE
  Future<Response?> changePasswordService(data) async {
    try {
      String url = "$baseUrl$changePassword";
      String token = await LocalStorage().fetchUserToken();

      var response = await _dio.post(url,
          data: data,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          }));
      return response;
    } catch (error) {
      if (error is DioException) {
        log("$error");
        return error.response;
      } else {
        throw Exception(error);
      }
    }
  }
}
