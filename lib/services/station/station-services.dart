import 'dart:developer';
import 'package:dio/dio.dart';
import '../../core/local-storage/local-storage.dart';
import '../../core/routes/api/api-routes.dart';

class StationServices {
  final Dio _dio = Dio();

  // GET PROFILE
  Future<Response?> getStationTypesService() async {
    try {
      String url = "$baseUrl$getStationTypes";
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

  // GET PRICE REFERENCE
  Future<Response?> getPriceReferenceService() async {
    try {
      String url = "$baseUrl$getPriceReference";
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

  // GET ALL STATIONS
  Future<Response?> getAllStationServices(
      {longitude, latitude, type, keyword, pageToken}) async {
    try {
      String url =
          // "$baseUrl$getAllStations?longitude=7.4017445&latitude=9.0686384&type=$type&nextPageToken=$pageToken&locationKeyword=Abuja";
          "$baseUrl$getAllStations?longitude=$longitude&latitude=$latitude&type=$type&nextPageToken=$pageToken&locationKeyword=$keyword";
      log(url);
      String token = await LocalStorage().fetchUserToken();
      var response = await _dio.get(
        url,
        options: Options(
            headers: {"accept": "*/*", "Authorization": "Bearer $token"}),
      );
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

  // SEARCH FOR STATIONS
  Future<Response?> searchForStationServices(
      {longitude, latitude, location, searchQuery, pageToken}) async {
    try {
      String url =
          "$baseUrl$stationSearch?longitude=$longitude&latitude=$latitude&locationKeyword=$location&searchKeyword=$searchQuery";
      // "$baseUrl$stationSearch?longitude=7.4017445&latitude=9.0686384&locationKeyword=Abuja&searchKeyword=$searchQuery";
      log(url);
      String token = await LocalStorage().fetchUserToken();
      var response = await _dio.get(
        url,
        options: Options(
            headers: {"accept": "*/*", "Authorization": "Bearer $token"}),
      );
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

  // UPDATE STATION PRICE
  Future<Response?> updateStationPriceService(data) async {
    try {
      String url = "$baseUrl$updateStationDetails/update-prices";
      String token = await LocalStorage().fetchUserToken();
      var response = await _dio.post(
        url,
        data: data,
        options: Options(
            headers: {"accept": "*/*", "Authorization": "Bearer $token"}),
      );
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

  // UPDATE QUEUE REPORT
  Future<Response?> updateStationQueueReportService(data, id, query) async {
    try {
      String url = "$baseUrl$updateStationDetails/$id/queue";
      String token = await LocalStorage().fetchUserToken();
      var response = await _dio.post(url,
          data: data,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          }),
          queryParameters: query);
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

  // UPDATE METER REPORT
  Future<Response?> updateStationMeterReportService(data, id, query) async {
    try {
      String url = "$baseUrl$updateStationDetails/$id/meter-report";
      String token = await LocalStorage().fetchUserToken();
      var response = await _dio.post(url,
          data: data,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          }),
          queryParameters: query);
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

  // ADD TO FAVORITE
  Future<Response?> addToFavoriteService(id) async {
    try {
      String url = "$baseUrl$addToFavorite";
      String token = await LocalStorage().fetchUserToken();
      var response = await _dio.post(url,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          }),
          queryParameters: {"stationId": id});
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

  // REMOVE FROM FAVORITE
  Future<Response?> removeFromFavoriteService(id) async {
    try {
      String url = "$baseUrl$removeFromFavorite";
      String token = await LocalStorage().fetchUserToken();
      var response = await _dio.delete(url,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          }),
          queryParameters: {"stationId": id});
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

  // GET ALL FAVORITES
  Future<Response?> getAllFavoriteServices({query, name = ""}) async {
    try {
      String url =
          // "$baseUrl$getAllFavoriteStations?longitude=7.4444624&latitude=9.055259999999999";
          "$baseUrl$getAllFavoriteStations?latitude=${query["latitude"]}&longitude=${query["longitude"]}";
      log(url);
      String token = await LocalStorage().fetchUserToken();
      var response = await _dio.get(
        url,
        queryParameters: {"name": name},
        options: Options(headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        }),
      );
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

  // ADD STATIONS
  Future<Response?> addStationsServices(data) async {
    try {
      String url = "$baseUrl$addStation";
      String token = await LocalStorage().fetchUserToken();
      var response = await _dio.post(
        url,
        data: data,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        }),
      );
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

  // RATE A STATION
  Future<Response?> rateAStationService(data, id) async {
    try {
      String url = "$baseUrl$stationRating$id/ratings";
      String token = await LocalStorage().fetchUserToken();
      var response = await _dio.post(
        url,
        data: data,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        }),
      );
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

  // GET ALL STATION REVIEWS
  Future<Response?> getStationReviewService(id) async {
    try {
      String url = "$baseUrl$stationRating$id/ratings";
      String token = await LocalStorage().fetchUserToken();
      var response = await _dio.get(
        url,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        }),
      );
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

  // GET ALL STATION USER REVIEWS
  Future<Response?> getUserReviewService() async {
    try {
      String url = "$baseUrl$getUserReviews";
      String token = await LocalStorage().fetchUserToken();
      var response = await _dio.get(
        url,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        }),
      );
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

  // FILTER STATION SERVICE
  Future<Response?> filterStationService({data}) async {
    try {
      String url = "$baseUrl$filterStation";
      String token = await LocalStorage().fetchUserToken();
      var response = await _dio.get(
        url,
        queryParameters: data,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        }),
      );
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
