import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:fuel_alert/controller/profile/profile-state-controller.dart';
import 'package:fuel_alert/widget/buttons/buttons.dart';
import 'package:get/get.dart';

class EditProfileDialog {
  show(context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Theme.of(context).cardColor,
              insetPadding: EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              content:
                  GetBuilder<ProfileStateController>(builder: (controller) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Personal Information",
                          style: TextStyle(
                              fontFamily: "PoppinsSemiBold",
                              fontSize: 22,
                              color: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.color),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Full name",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.color,
                                    fontSize: 16,
                                    fontFamily: "PoppinsMeds"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: controller.fullName,
                                keyboardType: TextInputType.name,
                                validator: ValidationBuilder().build(),
                                decoration: InputDecoration(
                                  fillColor: Theme.of(context)
                                      .inputDecorationTheme
                                      .fillColor,
                                  filled: true,
                                  hintText: "Enter fullname",
                                  hintStyle: TextStyle(
                                      color: Color(0xffCCCCCC), fontSize: 16),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffD6D6D6),
                                          width: 0.76),
                                      borderRadius: BorderRadius.circular(50)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffD6D6D6),
                                          width: 0.76),
                                      borderRadius: BorderRadius.circular(50)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: BorderSide(
                                          color: Color(0xffFF0000),
                                          width: 0.76)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: BorderSide(
                                          color: Color(0xffFF0000),
                                          width: 0.76)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Username",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.color,
                                    fontSize: 16,
                                    fontFamily: "PoppinsMeds"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: controller.username,
                                keyboardType: TextInputType.name,
                                validator: ValidationBuilder().build(),
                                decoration: InputDecoration(
                                  fillColor: Theme.of(context)
                                      .inputDecorationTheme
                                      .fillColor,
                                  filled: true,
                                  hintText: "Enter username",
                                  hintStyle: TextStyle(
                                      color: Color(0xffCCCCCC), fontSize: 16),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffD6D6D6),
                                          width: 0.76),
                                      borderRadius: BorderRadius.circular(50)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffD6D6D6),
                                          width: 0.76),
                                      borderRadius: BorderRadius.circular(50)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: BorderSide(
                                          color: Color(0xffFF0000),
                                          width: 0.76)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: BorderSide(
                                          color: Color(0xffFF0000),
                                          width: 0.76)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Gender",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.color,
                                    fontSize: 16,
                                    fontFamily: "PoppinsMeds"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              DropdownButtonFormField(
                                // value: controller.gender.toString().isEmpty
                                //     ? null
                                //     : controller.gender,
                                items: controller.genders
                                    .map((e) => DropdownMenuItem(
                                        value: e, child: Text(e)))
                                    .toList(),
                                onChanged: (value) {
                                  controller.updateSelectedGender(value);
                                },
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.color,
                                ),
                                decoration: InputDecoration(
                                  fillColor: Theme.of(context)
                                      .inputDecorationTheme
                                      .fillColor,
                                  filled: true,
                                  hintText: "Select gender",
                                  hintStyle: TextStyle(
                                      color: Color(0xffCCCCCC), fontSize: 16),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffD6D6D6),
                                          width: 0.76),
                                      borderRadius: BorderRadius.circular(50)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffD6D6D6),
                                          width: 0.76),
                                      borderRadius: BorderRadius.circular(50)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: BorderSide(
                                          color: Color(0xffFF0000),
                                          width: 0.76)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: BorderSide(
                                          color: Color(0xffFF0000),
                                          width: 0.76)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Mobile number",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.color,
                                    fontSize: 16,
                                    fontFamily: "PoppinsMeds"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.name,
                                controller: controller.phone,
                                validator: ValidationBuilder().build(),
                                decoration: InputDecoration(
                                  fillColor: Theme.of(context)
                                      .inputDecorationTheme
                                      .fillColor,
                                  filled: true,
                                  hintText: "Enter mobile number",
                                  hintStyle: TextStyle(
                                      color: Color(0xffCCCCCC), fontSize: 16),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffD6D6D6),
                                          width: 0.76),
                                      borderRadius: BorderRadius.circular(50)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffD6D6D6),
                                          width: 0.76),
                                      borderRadius: BorderRadius.circular(50)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: BorderSide(
                                          color: Color(0xffFF0000),
                                          width: 0.76)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: BorderSide(
                                          color: Color(0xffFF0000),
                                          width: 0.76)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.color,
                                    fontSize: 16,
                                    fontFamily: "PoppinsMeds"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                enabled: false,
                                controller: controller.email,
                                keyboardType: TextInputType.name,
                                validator: ValidationBuilder().email().build(),
                                decoration: InputDecoration(
                                  fillColor: Theme.of(context)
                                      .inputDecorationTheme
                                      .fillColor,
                                  filled: true,
                                  hintText: "Enter email",
                                  hintStyle: TextStyle(
                                      color: Color(0xffCCCCCC), fontSize: 16),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffD6D6D6),
                                          width: 0.76),
                                      borderRadius: BorderRadius.circular(50)),
                                  disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffD6D6D6),
                                          width: 0.76),
                                      borderRadius: BorderRadius.circular(50)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffD6D6D6),
                                          width: 0.76),
                                      borderRadius: BorderRadius.circular(50)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: BorderSide(
                                          color: Color(0xffFF0000),
                                          width: 0.76)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: BorderSide(
                                          color: Color(0xffFF0000),
                                          width: 0.76)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Address",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.color,
                                    fontSize: 16,
                                    fontFamily: "PoppinsMeds"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: controller.addresss,
                                keyboardType: TextInputType.name,
                                validator: ValidationBuilder().build(),
                                decoration: InputDecoration(
                                  fillColor: Theme.of(context)
                                      .inputDecorationTheme
                                      .fillColor,
                                  filled: true,
                                  hintText: "Enter address",
                                  hintStyle: TextStyle(
                                      color: Color(0xffCCCCCC), fontSize: 16),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffD6D6D6),
                                          width: 0.76),
                                      borderRadius: BorderRadius.circular(50)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffD6D6D6),
                                          width: 0.76),
                                      borderRadius: BorderRadius.circular(50)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: BorderSide(
                                          color: Color(0xffFF0000),
                                          width: 0.76)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: BorderSide(
                                          color: Color(0xffFF0000),
                                          width: 0.76)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Buttons().cancelButtons(context,
                                  title: "Cancel", action: () {
                                Get.back();
                              }),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Buttons().defaultButtons(
                                  isLoading: controller.isLoading,
                                  title: "Save",
                                  action: () {
                                    controller.updateProfile(context);
                                  }),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }),
            ));
  }
}
