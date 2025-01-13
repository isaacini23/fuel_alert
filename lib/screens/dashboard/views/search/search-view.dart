import 'package:flutter/material.dart';
import 'package:fuel_alert/controller/home/home-state-controller.dart';
import 'package:fuel_alert/screens/dashboard/views/search/recent-search-view.dart';
import 'package:fuel_alert/screens/dashboard/views/search/search-result-view.dart';
import 'package:get/get.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeStateController>(
      builder: (controller) {
        return Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: (controller.searchText.text.isEmpty || controller.allSearchStations.isEmpty)?
          const RecentSearchView():
          const SearchResultView()
        );
      }
    );
  }
}
