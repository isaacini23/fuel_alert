import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:fuel_alert/core/functions/url-launcher.dart';
import 'package:fuel_alert/core/routes/app/app-route-names.dart';
import 'package:fuel_alert/widget/buttons/buttons.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../controller/authentication/auth-state-controller.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthStateController authStateController =
      Get.put(AuthStateController());

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
            "Sign In",
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
                          decoration: const InputDecoration(
                            hintText: "Enter email address",
                            hintStyle: TextStyle(
                                color: Color(0xffCCCCCC), fontSize: 16),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff009933), width: 0.76)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffFF0000), width: 0.76)),
                            focusedErrorBorder: OutlineInputBorder(
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
                          "Password",
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
                            hintText: "Enter password",
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
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Row(
                        children: [
                          Checkbox(
                            value: controller.isRemembered,
                            onChanged: (value) {
                              controller.toggleIsRemembered();
                            },
                            activeColor: const Color(0xff009933),
                            side: const BorderSide(color: Color(0xffD9D9D9)),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(1.2)),
                          ),
                          Text(
                            "Stay logged in",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.color,
                                fontFamily: "PoppinsMeds",
                                fontSize: 14),
                          )
                        ],
                      )),
                      InkWell(
                        onTap: () {
                          Get.toNamed(forgotPasswordScreen);
                        },
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                              color: Color(0xff009933),
                              fontFamily: "PoppinsMeds",
                              fontSize: 14),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Buttons().defaultButtons(
                      isLoading: controller.isLoading,
                      title: "Sign In",
                      action: () {
                        (_formKey.currentState!.validate())
                            ? controller.login()
                            : AutovalidateMode.disabled;
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  Buttons().borderButtons(
                      context,
                      title: "Continue as Guest",
                      action: () {
                        Get.offAllNamed(dashboard);
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 25),
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         child: Divider(),
                  //       ),
                  //       SizedBox(
                  //         width: 20,
                  //       ),
                  //       Expanded(
                  //         child: Text(
                  //           "or sign in with",
                  //           textAlign: TextAlign.center,
                  //           style: TextStyle(
                  //             color: Theme.of(context)
                  //                 .textTheme
                  //                 .titleMedium
                  //                 ?.color,
                  //             fontSize: 16,
                  //           ),
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         width: 20,
                  //       ),
                  //       Expanded(
                  //         child: Divider(),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     InkWell(
                  //       onTap: () {
                  //         controller.triggerGoogle(context);
                  //       },
                  //       child: SvgPicture.asset(
                  //         "assets/images/Google.svg",
                  //         width: 35,
                  //         height: 38,
                  //       ),
                  //     ),
                  //     // const SizedBox(
                  //     //   width: 30,
                  //     // ),
                  //     // SvgPicture.asset(
                  //     //   "assets/images/Facebook.svg",
                  //     //   width: 55,
                  //     //   height: 60,
                  //     // ),
                  //     const SizedBox(
                  //       width: 30,
                  //     ),
                  //     InkWell(
                  //       onTap: () {
                  //         controller.triggerAppleAuth(context);
                  //       },
                  //       child: SvgPicture.asset(
                  //         "assets/images/Apple.svg",
                  //         width: 35,
                  //         height: 38,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: TextSpan(
                        text: "Don’t have an account yet? ",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            color:
                                Theme.of(context).textTheme.titleMedium?.color),
                        children: [
                          WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(signUpScreen);
                                },
                                child: const Text("Sign up",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        decorationColor: Color(0xff009933),
                                        fontFamily: "Poppins",
                                        fontSize: 16,
                                        color: Color(0xff009933))),
                              )),
                        ]),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              border: Border(top: BorderSide(color: Color(0xffD6D6D6)))),
          child: RichText(
            text: TextSpan(
                text: "By clicking Create Account you agree to the ",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14.38,
                    color: Theme.of(context).textTheme.titleMedium?.color),
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: InkWell(
                      onTap: () {
                        launchUrls("https://www.fuelalertng.com/terms");
                      },
                      child: const Text("Terms ",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14.38,
                              color: Color(0xff009933))),
                    ),
                  ),
                  TextSpan(
                      text: "and ",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14.38,
                          color:
                              Theme.of(context).textTheme.titleMedium?.color)),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: InkWell(
                      onTap: () {
                        launchUrls("https://www.fuelalertng.com/privacy");
                      },
                      child: const Text("Privacy Policy",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14.38,
                              color: Color(0xff009933))),
                    ),
                  ),
                ]),
          ),
        ),
      );
    });
  }
}
