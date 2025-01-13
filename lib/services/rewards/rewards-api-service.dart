import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:fuel_alert/core/local-storage/local-storage.dart';
import 'package:fuel_alert/core/routes/api/api-routes.dart';

class RewardsApiService {
  
  final Dio _dio = Dio();

  // GET REWARD LEADERBOARD
  Future<Response?> getRewardLeaderBoardService() async {
    try {
      String url = "$baseUrl$getRewardLeaderBoard";
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

  // GET POINT CONFIG
  Future<Response?> getPointConfigService() async {
    try {
      String url = "$baseUrl$getPointsConfig";
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

  // UPDATE REWARD POINT CONFIG
  Future<Response?> updaterewardPointConfigService(data) async {
    try {
      String url = "$baseUrl$updatePointsConfig";
      String token = await LocalStorage().fetchUserToken();
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

}