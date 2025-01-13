import 'dart:developer';
import 'package:fuel_alert/models/points-config.dart';
import 'package:fuel_alert/services/rewards/rewards-api-service.dart';
import 'package:get/get.dart';

class RewardStateController extends GetxController {
  bool _isLoading = false;
  List<dynamic> _leadershipBoard = [];
  PointConfig _pointConfig = PointConfig();

  bool get isLoading => _isLoading;
  List<dynamic> get leadershipBoard => _leadershipBoard;
  PointConfig get pointConfig => _pointConfig;

  updateIsLoading(value) {
    _isLoading = value;
    update();
  }

  updateLeadershipBoard(value) {
    _leadershipBoard = value;
    update();
  }

  Future getRewardLeadershipBoard() async {
    updateIsLoading(true);

    var response = await RewardsApiService().getRewardLeaderBoardService();

    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      updateIsLoading(false);

      updateLeadershipBoard(responseData["data"]);
    } else {
      updateIsLoading(false);
    }

    update();
  }

  Future getPointsConfig() async {
    updateIsLoading(true);

    var response = await RewardsApiService().getPointConfigService();

    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      updateIsLoading(false);

      _pointConfig = PointConfig.fromMap(responseData["data"]);

    } else {
      updateIsLoading(false);
    }

    update();
  }

}
