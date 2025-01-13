import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:fuel_alert/controller/authentication/auth-state-controller.dart';
import 'package:fuel_alert/widget/buttons/buttons.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

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
            "Reset your password",
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
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "New Password",
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
                            controller.updatePassword(value);
                          },
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: !controller.showPassword,
                          validator: ValidationBuilder().build(),
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: () {
                                controller.toggleShowPassword();
                              },
                              child: Icon(
                                controller.showPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: const Color(0xffCCCCCC),
                              ),
                            ),
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
                    height: 20,
                  ),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Confirm Password",
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
                            controller.updatePasswordConfirm(value);
                          },
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: !controller.showPassword,
                          validator: ValidationBuilder().build(),
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: () {
                                controller.toggleShowPassword();
                              },
                              child: Icon(
                                controller.showPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: const Color(0xffCCCCCC),
                              ),
                            ),
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
                      title: "Confirm",
                      action: () {
                        (_formKey.currentState!.validate())
                            ? (controller.passwordConfirm ==
                                    controller.password)
                                ? controller.resetPassword()
                                : Get.snackbar(
                                    "Failed", "Password does not match!",
                                    colorText: Colors.white,
                                    backgroundColor: const Color(0xffFF0000))
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
