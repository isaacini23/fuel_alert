import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:fuel_alert/controller/profile/profile-state-controller.dart';
import 'package:fuel_alert/widget/buttons/buttons.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChangePasswordView extends StatelessWidget {
  ChangePasswordView({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileStateController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          elevation: 2,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Iconsax.arrow_left,
              )),
          shadowColor: Colors.black.withOpacity(0.15),
          centerTitle: true,
          title: Text(
            "Change Password",
            style: TextStyle(
                fontFamily: "PoppinsSemiBold",
                fontSize: 24,
                color: Theme.of(context).textTheme.titleLarge?.color),
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Theme.of(context).canvasColor,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Current Password",
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.titleSmall?.color,
                              fontSize: 16,
                              fontFamily: "PoppinsMeds"),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          obscureText: true,
                          onChanged: (value) {
                            controller.updateOldPassword(value);
                          },
                          keyboardType: TextInputType.visiblePassword,
                          validator: ValidationBuilder().build(),
                          decoration: InputDecoration(
                            fillColor: Theme.of(context)
                                .inputDecorationTheme
                                .fillColor,
                            filled: true,
                            hintText: "Enter current password",
                            hintStyle: const TextStyle(
                                color: Color(0xffCCCCCC), fontSize: 16),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .inputDecorationTheme
                                      .enabledBorder!
                                      .borderSide
                                      .color,
                                ),
                                borderRadius: BorderRadius.circular(50)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                    color: Color(0xffFF0000), width: 0.76)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                    color: Color(0xffFF0000), width: 0.76)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "New password",
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.titleSmall?.color,
                              fontSize: 16,
                              fontFamily: "PoppinsMeds"),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          obscureText: true,
                          onChanged: (value) {
                            controller.updateNewPassword(value);
                          },
                          keyboardType: TextInputType.visiblePassword,
                          validator: ValidationBuilder().build(),
                          decoration: InputDecoration(
                            fillColor: Theme.of(context)
                                .inputDecorationTheme
                                .fillColor,
                            filled: true,
                            hintText: "Enter new password",
                            hintStyle: const TextStyle(
                                color: Color(0xffCCCCCC), fontSize: 16),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .inputDecorationTheme
                                      .enabledBorder!
                                      .borderSide
                                      .color,
                                ),
                                borderRadius: BorderRadius.circular(50)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                    color: Color(0xffFF0000), width: 0.76)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                    color: Color(0xffFF0000), width: 0.76)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Confirm password",
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.titleSmall?.color,
                              fontSize: 16,
                              fontFamily: "PoppinsMeds"),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          obscureText: true,
                          onChanged: (value) {
                            controller.updateConfirmPassword(value);
                          },
                          keyboardType: TextInputType.visiblePassword,
                          validator: ValidationBuilder().build(),
                          decoration: InputDecoration(
                            fillColor: Theme.of(context)
                                .inputDecorationTheme
                                .fillColor,
                            filled: true,
                            hintText: "Re-enter password",
                            hintStyle: const TextStyle(
                                color: Color(0xffCCCCCC), fontSize: 16),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .inputDecorationTheme
                                      .enabledBorder!
                                      .borderSide
                                      .color,
                                ),
                                borderRadius: BorderRadius.circular(50)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                    color: Color(0xffFF0000), width: 0.76)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                    color: Color(0xffFF0000), width: 0.76)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Buttons().defaultButtons(
                      isLoading: controller.isLoading,
                      title: "Change password",
                      action: () {
                        (_formKey.currentState!.validate())
                            ? controller.changePassword()
                            : AutovalidateMode.disabled;
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  Buttons().cancelButtons(context, title: "Cancel", action: () {
                    Get.back();
                  }),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
