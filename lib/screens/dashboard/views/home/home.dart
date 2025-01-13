import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fuel_alert/controller/home/home-state-controller.dart';
import 'package:fuel_alert/controller/theme/theme-controller.dart';
import 'package:fuel_alert/core/routes/app/app-route-names.dart';
import 'package:fuel_alert/screens/dashboard/views/home/views/all.dart';
import 'package:fuel_alert/screens/dashboard/views/home/views/cooking-gas.dart';
import 'package:fuel_alert/screens/dashboard/views/home/views/diesel.dart';
import 'package:fuel_alert/screens/dashboard/views/home/views/kerosene.dart';
import 'package:fuel_alert/screens/dashboard/views/home/views/petrol.dart';
import 'package:fuel_alert/screens/dashboard/views/maps/main-map-view.dart';
import 'package:fuel_alert/screens/dashboard/views/search/recent-search-view.dart';
import 'package:fuel_alert/screens/dashboard/views/search/views/all.dart';
import 'package:fuel_alert/screens/dashboard/views/search/views/cooking-gas.dart';
import 'package:fuel_alert/screens/dashboard/views/search/views/diesel.dart';
import 'package:fuel_alert/screens/dashboard/views/search/views/kerosene.dart';
import 'package:fuel_alert/screens/dashboard/views/search/views/petrol.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    
    return GetBuilder<HomeStateController>(builder: (controller) {
      return DefaultTabController(
        length: 5,
        child: Scaffold(
            backgroundColor: Theme.of(context).inputDecorationTheme.fillColor,
            body: (controller.isMapVisible)
                ? MainMapView(
                  type: controller.selectedMapViewType,
                )
                : NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        SliverAppBar(
                          surfaceTintColor:
                              Theme.of(context).appBarTheme.surfaceTintColor,
                          backgroundColor:
                              Theme.of(context).appBarTheme.surfaceTintColor,
                          elevation: 4,
                          automaticallyImplyLeading: false,
                          floating: true,
                          pinned: true,
                          snap: true,
                          expandedHeight: 110,
                          title: (controller.isSearchActive)
                              ? Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        controller.updateIsSearchActive();
                                        controller.updateSearchText("");
                                        controller.clearSearchLists();
                                      },
                                      child: Icon(
                                        Icons.arrow_back,
                                        color:
                                            Theme.of(context).iconTheme.color,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        height: 45,
                                        child: TextFormField(
                                          controller: controller.searchText,
                                          onChanged: (value) {
                                            controller
                                                .updateSearchText(value);
                                            controller.searchForStation();
                                          },
                                          decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                              Iconsax.search_normal_1,
                                              color: Color(0xff009933),
                                            ),
                                            fillColor: Theme.of(context)
                                                .inputDecorationTheme
                                                .fillColor,
                                            filled: true,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 10),
                                            hintText: "Search for stations",
                                            hintStyle: const TextStyle(
                                                color: Color(0xffCCCCCC),
                                                fontSize: 16),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        50)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        50)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : GetBuilder<ThemeController>(
                                  builder: (themeController) {
                                  return SvgPicture.asset(
                               themeController.selectedTheme.value == ThemeMode.light
                                  ? "assets/images/FuelAlert Logo.svg"
                                  : themeController.selectedTheme.value == ThemeMode.dark
                                      ? "assets/images/light-logo.svg"
                                      : brightness == Brightness.dark
                                          ? "assets/images/light-logo.svg"
                                          : "assets/images/FuelAlert Logo.svg",
                                    height: 47,
                                    width: 155,
                                  );
                                }),
                          actions: [
                            (controller.isSearchActive)
                                ? const SizedBox.shrink()
                                : InkWell(
                                    onTap: () {
                                      Get.toNamed(notificationView);
                                    },
                                    child: Badge.count(
                                      count: controller.countNotificationsForCurrentWeek(controller.userNotificationList),
                                      child: CircleAvatar(
                                        radius: 22.5,
                                        backgroundColor:
                                            Theme.of(context).canvasColor,
                                        child: const Icon(
                                          Iconsax.notification,
                                          color: Color(0xff009933),
                                        ),
                                      ),
                                    )),
                            const SizedBox(
                              width: 10,
                            ),
                            (controller.isSearchActive)
                                ? const SizedBox.shrink()
                                : InkWell(
                                    onTap: () {
                                      controller.updateIsSearchActive();
                                    },
                                    child: CircleAvatar(
                                      radius: 22.5,
                                      backgroundColor:
                                          Theme.of(context).canvasColor,
                                      child: const Icon(
                                        Iconsax.search_normal_1,
                                        color: Color(0xff009933),
                                      ),
                                    )),
                            const SizedBox(
                              width: 10,
                            ),
                            (controller.isSearchActive)
                                ? const SizedBox()
                                : InkWell(
                                    onTap: () {
                                      Get.toNamed(filterStationScreen);
                                    },
                                    child: CircleAvatar(
                                      radius: 22.5,
                                      backgroundColor:
                                          Theme.of(context).canvasColor,
                                      child: const Icon(
                                        Iconsax.setting_4,
                                        color: Color(0xff009933),
                                      ),
                                    ),
                                  ),
                            const SizedBox(
                              width: 15,
                            ),
                          ],
                          flexibleSpace: FlexibleSpaceBar(
                            background: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .appBarTheme
                                    .backgroundColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    offset: const Offset(0,
                                        4), // Change this for different shadow
                                    blurRadius:
                                        10, // Change this for different shadow spread
                                  ),
                                ],
                              ),
                            ),
                          ),
                          bottom: const TabBar(
                            padding: EdgeInsets.only(left: 15),
                            tabAlignment: TabAlignment.start,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorColor: Color(0xff009933),
                            dividerHeight: 0,
                            isScrollable: true,
                            labelStyle: TextStyle(
                              color: Color(0xff009933),
                              fontFamily: "PoppinsMeds",
                              fontSize: 14,
                            ),
                            unselectedLabelStyle: TextStyle(
                              color: Color(0xff9599AD),
                              fontFamily: "PoppinsMeds",
                              fontSize: 14,
                            ),
                            tabs: [
                              Tab(text: "All"),
                              Tab(text: "Petrol"),
                              Tab(text: "Diesel"),
                              Tab(text: "Cooking gas"),
                              Tab(text: "Kerosene"),
                            ],
                          ),
                        ),
                      ];
                    },
                    body: (controller.isSearchActive)
                        ? (controller.searchText.text.isEmpty &&
                                controller.allSearchStations.isEmpty)
                            ? const RecentSearchView()
                            : controller.allSearchStations.isNotEmpty &&
                                    controller.searchText.text.isEmpty
                                ? const TabBarView(children: [
                                    SearchAllView(),
                                    SearchPetrolView(),
                                    SearchDieselView(),
                                    SearchCookingGasView(),
                                    SearchKeroseneView(),
                                  ])
                                : const TabBarView(children: [
                                    SearchAllView(),
                                    SearchPetrolView(),
                                    SearchDieselView(),
                                    SearchCookingGasView(),
                                    SearchKeroseneView(),
                                  ])
                        : const TabBarView(children: [
                            AllView(),
                            PetrolView(),
                            DieselView(),
                            CookingGasView(),
                            KeroseneView(),
                          ]),
                  )),
      );
    });
  }
}
