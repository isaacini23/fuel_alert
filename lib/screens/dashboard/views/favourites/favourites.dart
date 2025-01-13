import 'package:flutter/material.dart';
import 'package:fuel_alert/controller/home/home-state-controller.dart';
import 'package:fuel_alert/screens/dashboard/views/favourites/views/all.dart';
import 'package:fuel_alert/screens/dashboard/views/favourites/views/cooking-gas.dart';
import 'package:fuel_alert/screens/dashboard/views/favourites/views/diesel.dart';
import 'package:fuel_alert/screens/dashboard/views/favourites/views/kerosene.dart';
import 'package:fuel_alert/screens/dashboard/views/favourites/views/petrol.dart';
import 'package:fuel_alert/screens/dashboard/views/maps/main-map-view.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FavouriteView extends StatelessWidget {
  FavouriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeStateController>(builder: (controller) {
      return DefaultTabController(
        length: 5,
        child: Scaffold(
            backgroundColor: Theme.of(context).inputDecorationTheme.fillColor,
            body: (controller.isFavMapView)
                ? MainMapView(
                  type: controller.selectedMapViewType,
                )
                : CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        surfaceTintColor:
                            Theme.of(context).appBarTheme.surfaceTintColor,
                        backgroundColor:
                            Theme.of(context).appBarTheme.surfaceTintColor,
                        elevation: 2,
                        automaticallyImplyLeading: false,
                        // expandedHeight: 160,
                        floating: true,
                        pinned: true,
                        snap: true,
                        title: SizedBox(
                          height: 45,
                          child: TextFormField(
                            controller: controller.favoriteSearchText,
                            onChanged: (value) {
                              value.isEmpty
                                  ? controller.getFavouriteStations()
                                  : controller.getFavouriteStations(
                                      name: value);
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Iconsax.search_normal_1,
                                color: Color(0xff009933),
                              ),
                              fillColor: Theme.of(context).canvasColor,
                              filled: true,
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 10),
                              hintText: "Search for stations",
                              hintStyle: const TextStyle(
                                  color: Color(0xffCCCCCC), fontSize: 16),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(50)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                          ),
                        ),
                        // actions: [
                        //   InkWell(
                        //     onTap: () {},
                        //     child: SvgPicture.asset("assets/images/filter.svg"),
                        //   ),
                        //   const SizedBox(
                        //     width: 15,
                        //   ),
                        // ],
                        flexibleSpace: FlexibleSpaceBar(
                          background: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(context).appBarTheme.backgroundColor,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xff9599AD).withOpacity(0.05),
                                  offset: const Offset(0, 4),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        bottom: controller.isSearchActive
                            ? null
                            : const TabBar(
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
                      const SliverFillRemaining(
                        child: TabBarView(children: [
                          FavoriteAllView(),
                          FavoritePetrolView(),
                          FavoriteDieselView(),
                          FavoriteCookingGasView(),
                          FavoriteKeroseneView(),
                        ]),
                      ),
                    ],
                  )),
      );
    });
  }
}
