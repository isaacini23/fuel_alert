import 'dart:developer';
import 'package:dio/dio.dart';
import '../../core/routes/api/api-routes.dart';

class AuthServices {

  final Dio _dio = Dio();

  // LOGIN
  Future<Response?> loginService(data) async{
    try {
      String url = "$baseUrl$login";
      var response = await _dio.post(
        url,
        data: data
      );
      return response;

    } catch (error) {
      if(error is DioException){
        log("$error");
        return error.response;
      }else {
        throw Exception(error);
      }
    }
  }

  // SOCIAL LOGIN SERVICE
  Future<Response?> googleAuthLoginService(data) async{
    try {
      String url = "$baseUrl$googleAuth";
      var response = await _dio.post(
        url,
        data: data,
      );
      return response;

    } catch (error) {
      if(error is DioException){
        log("$error");
        return error.response;
      }else {
        throw Exception(error);
      }
    }
  }

  // SOCIAL LOGIN SERVICE
  Future<Response?> appleAuthLoginService(data) async{
    try {
      String url = "$baseUrl$googleAuth";
      var response = await _dio.post(
        url,
        data: data,
      );
      return response;

    } catch (error) {
      if(error is DioException){
        log("$error");
        return error.response;
      }else {
        throw Exception(error);
      }
    }
  }

  // REGISTER
  Future<Response?> registerService(data) async{
    try {
      String url = "$baseUrl$register";
      log(url);
      var response = await _dio.post(
        url,
        data: data
      );
      return response;

    } catch (error) {
      if(error is DioException){
        log("$error");
        return error.response;
      }else {
        throw Exception(error);
      }
    }
  }

  // VERIFY EMAIL CODE
  Future<Response?> verifyEmailCodeService(data) async{
    try {
      String url = "$baseUrl$verifyEmailOtp";
      var response = await _dio.post(
        url,
        data: data,
      );
      return response;

    } catch (error) {
      if(error is DioException){
        log("$error");
        return error.response;
      }else {
        throw Exception(error);
      }
    }
  }

  // FORGOT PASSWORD
  Future<Response?> forgotPasswordService(data) async{
    try {
      String url = "$baseUrl$forgotPassword";
      var response = await _dio.post(
        url,
        data: data
      );
      return response;

    } catch (error) {
      if(error is DioException){
        log("$error");
        return error.response;
      }else {
        throw Exception(error);
      }
    }
  }

  // RESET PASSWORD
  Future<Response?> resetPasswordService(data) async{
    try {
      String url = "$baseUrl$resetPassword";
      var response = await _dio.post(
        url,
        data: data,
      );
      return response;

    } catch (error) {
      if(error is DioException){
        log("$error");
        return error.response;
      }else {
        throw Exception(error);
      }
    }
  }

  // RESEND EMAIL
  Future<Response?> resendEmailService(data) async{
    try {
      String url = "$baseUrl$resendEmail";
      var response = await _dio.post(
        url,
        data: data,
      );
      return response;

    } catch (error) {
      if(error is DioException){
        log("$error");
        return error.response;
      }else {
        throw Exception(error);
      }
    }
  }

}