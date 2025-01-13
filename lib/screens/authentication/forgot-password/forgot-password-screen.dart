import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:fuel_alert/controller/authentication/auth-state-controller.dart';
import 'package:fuel_alert/widget/buttons/buttons.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthStateController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Iconsax.arrow_left,
              )),
          centerTitle: true,
          title: Text(
            "Find your account",
            style: TextStyle(
                fontFamily: "PoppinsSemiBold",
                fontSize: 28,
                color: Theme.of(context).textTheme.titleLarge?.color),
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: Theme.of(context).canvasColor,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Please enter your email to get an otp",
                    style: TextStyle(
                        fontFamily: "PoppinsSemiBold",
                        fontSize: 16,
                        color: Color(0xff626262)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email Address",
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
                          onChanged: (value) {
                            controller.updateEmail(value);
                          },
                          keyboardType: TextInputType.emailAddress,
                          validator: ValidationBuilder().email().build(),
                          decoration: InputDecoration(
                            hintText: "Enter email address",
                            hintStyle: const TextStyle(
                                color: Color(0xffCCCCCC), fontSize: 16),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff009933), width: 0.76)),
                            errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffFF0000), width: 0.76)),
                            focusedErrorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffFF0000), width: 0.76)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Buttons().defaultButtons(
                      isLoading: controller.isLoading,
                      title: "Submit",
                      action: () {
                        (_formKey.currentState!.validate())
                            ? controller.forgotPassword()
                            : AutovalidateMode.disabled;
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
