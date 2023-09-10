import 'dart:math';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/helpers/constants.dart';
import '../../../utils/helpers/routers/router.dart';
import '../../widgets/animated_auth_widget.dart';
import '../../widgets/custom_auth_button_widget.dart';
import '../../widgets/custom_logo_widget.dart';
import '../../widgets/custom_outlined_button_widget.dart';
import '../../widgets/custom_text_forn_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  late bool showSignUp;
  late bool showLogin;

  int value = 0; //for the AnimatedToggleSwitch
  void clearTextField() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  void toggleView() {
    setState(() {
      clearTextField();
      showSignUp = !showSignUp;
      showLogin = !showLogin;
    });
  }

  @override
  void initState() {
    showSignUp = true;
    showLogin = false;
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: -170.h,
                child: Container(
                  height: 571.h,
                  width: 571.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: kGradient,
                  ),
                  child: const CustomLogoWidget(),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(48),
                      margin:
                          const EdgeInsets.only(left: 31, right: 31, top: 200),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(59),
                        color: kWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromRGBO(205, 204, 241, 0.3),
                            blurRadius:
                                7.5.r, // has the effect of softening the shadow
                            spreadRadius:
                                0.r, // has the effect of extending the shadow
                            offset: const Offset(
                              5.0, // horizontal, move right 5
                              0,
                            ),
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DefaultTextStyle(
                            style: theme.textTheme.titleLarge!,
                            textAlign: TextAlign.center,
                            child: SingleChildScrollView(
                              child: AnimatedToggleSwitch<int>.size(
                                current: min(value, 1),
                                style: ToggleStyle(
                                  backgroundColor: Colors.transparent,
                                  indicatorColor: kPrimaryBlueColor,
                                  borderColor: kLightGreyColor,
                                  borderRadius: BorderRadius.circular(25.0),
                                  indicatorBorderRadius:
                                      BorderRadius.circular(50.0),
                                ),
                                values: const [0, 1],
                                selectedIconScale: 1.0, //change font scaLe
                                indicatorSize: const Size.fromWidth(100),
                                styleAnimationType: AnimationType.onHover,
                                spacing: 2.0,

                                customIconBuilder: (context, local, global) {
                                  final text = [
                                    'sign_up'.tr(),
                                    'log_in'.tr(),
                                  ][local.index];
                                  return Center(
                                    child: Text(
                                      text,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.lerp(
                                          FontWeight.normal,
                                          FontWeight.bold,
                                          local.animationValue,
                                        ), //adjust fontweight on toggle
                                        fontSize: 14,

                                        letterSpacing: 0.25,
                                        color: Color.lerp(
                                          kPrimaryBlueColor,
                                          Colors.white,
                                          local.animationValue,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                borderWidth: 1.0,
                                onChanged: (i) => setState(() {
                                  value = i;
                                  toggleView();
                                }),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          AnimatedAuthWidget(
                              textEditingController: CustomTextFormFieldWidget(
                                controller: nameController,
                                hint: 'enter_name'.tr(),
                                keyboardType: TextInputType.emailAddress,
                                autofillHints: const [AutofillHints.email],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'please_enter_the_name'.tr();
                                  }
                                  return null;
                                },
                              ),
                              condition: showSignUp),
                          SizedBox(
                            height: 10.h,
                          ),
                          CustomTextFormFieldWidget(
                            controller: emailController,
                            hint: 'enter_email_or_username'.tr(),
                            keyboardType: TextInputType.emailAddress,
                            autofillHints: const [AutofillHints.email],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please_enter_the_email'.tr();
                              }
                              // else if (!EmailValidator.validate(value)) {
                              //   return 'please enter a valid email';
                              // }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          CustomTextFormFieldWidget(
                            controller: passwordController,
                            hint: 'enter_password'.tr(),
                            keyboardType: TextInputType.emailAddress,
                            autofillHints: const [AutofillHints.email],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please_enter_the_password'.tr();
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          AnimatedAuthWidget(
                              textEditingController: CustomTextFormFieldWidget(
                                controller: confirmPasswordController,
                                hint: 'confirm_password'.tr(),
                                keyboardType: TextInputType.emailAddress,
                                autofillHints: const [AutofillHints.email],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'please_enter_the_password_again'
                                        .tr();
                                  }
                                  return null;
                                },
                              ),
                              condition: showSignUp),
                          SizedBox(
                            height: 40.h,
                          ),
                          CustomAuthButtonWidget(
                            title: showSignUp == true
                                ? 'sign_up'.tr()
                                : 'log_in'.tr(),
                            onTap: () {
                              NavigationRoutes().jump(
                                  context, Routes.home_screen,
                                  replace: true);
                            },
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          Text(
                            'OR'.tr(),
                            style: GoogleFonts.poppins(
                                color: const Color(0xFFA8A7A7),
                                fontSize: 14,
                                letterSpacing: 0.25),
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomOtlinedButton(
                                child:
                                    Image.asset('assets/images/facebook.png'),
                              ),
                              CustomOtlinedButton(
                                child: Image.asset('assets/images/twitter.png'),
                              ),
                              CustomOtlinedButton(
                                child: Image.asset('assets/images/google.png'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
