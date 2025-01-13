import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuel_alert/controller/home/home-state-controller.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class CustomStationMarker extends StatelessWidget {
  const CustomStationMarker({
    super.key,
    required this.markerColor,
    required this.isSelected,
    required this.fuelPrice,
  });

  final Color markerColor;
  final bool isSelected;
  final num fuelPrice;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeStateController>(
      builder: (controller) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: markerColor,
                borderRadius: BorderRadius.circular(50),
                border: isSelected ? Border.all(color: const Color(0xffB0DFC0), width: 3) : null,
              ),
              child: Text.rich(
                TextSpan(
                  text: "₦",
                  style: const TextStyle(color: Colors.white, fontFamily: "InterSemiBold", fontSize: 12.92),
                  children: [
                    TextSpan(text: "$fuelPrice", style: const TextStyle(color: Colors.white, fontFamily: "PoppinsSemiBold", fontSize: 12.92)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            SvgPicture.asset(markerColor == const Color(0xff009933)
                ? "assets/images/green-marker.svg"
                : markerColor == const Color(0xffEA251D)
                    ? "assets/images/red-marker.svg"
                    : markerColor == const Color(0xffEBBC46)
                        ? "assets/images/yellow-marker.svg"
                        : "assets/images/green-marker.svg"),
            if (isSelected)
              Container(
                height: 10,
                width: 10,
                decoration:
                    BoxDecoration(color: markerColor, shape: BoxShape.circle, border: Border.all(color: const Color(0xffB0DFC0), width: 3)),
              ),
          ],
        );
      }
    );
  }
}