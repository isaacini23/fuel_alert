import 'dart:developer';
import 'package:dio/dio.dart';

import '../../core/local-storage/local-storage.dart';
import '../../core/routes/api/api-routes.dart';

class NotificationApiServices {
  final Dio _dio = Dio();

  // DISABLE NOTIFICATIONS
  Future<Response?> disableNotificationServices(data) async {
    try {
      String url = "$baseUrl$disableNotification";
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

  // ENABLE NOTIFICATIONS
  Future<Response?> enableNotificationsServices(data) async {
    try {
      String url = "$baseUrl$enableNotification";
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

  // GET ALL NOTIFICATIONS NOTIFICATIONS
  Future<Response?> getAllNotificationService() async {
    try {
      String url = "$baseUrl$getNotification";
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

}
