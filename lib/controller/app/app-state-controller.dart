
import 'package:flutter/material.dart';
import 'package:fuel_alert/screens/dashboard/views/favourites/favourites.dart';
import 'package:fuel_alert/screens/dashboard/views/home/home.dart';
import 'package:fuel_alert/screens/dashboard/views/rewards/rewards.dart';
import 'package:fuel_alert/screens/dashboard/views/settings/settings.dart';
import 'package:get/get.dart';

class AppStateController extends GetxController {
  List<Widget> _dashboardViews = [
    HomeView(),
    FavouriteView(),
    RewardsView(),
    SettingsView()
  ];
  int _viewIndex = 0;
  bool _isLoading = false;

  List<Widget> get dashboardViews => _dashboardViews;
  int get viewIndex => _viewIndex;
  bool get isLoading => _isLoading;

  updateViewIndex(value) {
    _viewIndex = value;
    update();
  }

  updateIsLoading(value) {
    _isLoading = value;
    update();
  }

}
