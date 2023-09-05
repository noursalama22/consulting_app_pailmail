import 'dart:math';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/helpers/constants.dart';
import '../../widgets/custom_auth_button_widget.dart';
import '../../widgets/custom_logo_widget.dart';
import '../../widgets/custom_outlined_button_widget.dart';
import '../../widgets/custom_text_forn_field_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  void ShowSignUpView() {
    setState(() {
      showSignUp = true;
      showLogin = false;
      print('login $showLogin');
      print('sign $showSignUp');
    });
  }

  void ShowLoginView() {
    setState(() {
      showSignUp = false;
      showLogin = true;
      print('login $showLogin');
      print('sign $showSignUp');
    });
  }

  @override
  void initState() {
    showSignUp = true;
    showLogin = false;
    super.initState();
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
                // left: -72.w,
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
                    // SizedBox(
                    //   height: 100.h,
                    // ),
                    AnimatedContainer(
                      duration: Duration(seconds: 1),
                      height: showSignUp ? 580.0.h : 563.0.h,

                      curve: Curves.easeInOut, // Animation curve
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
                              5.0, // horizontal, move right 10
                              0, // vertical, move down 10
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AnimatedToggleSwitch<int>.size(
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
                                    iconOpacity: 1.0,
                                    selectedIconScale: 1.0,
                                    indicatorSize: const Size.fromWidth(100),
                                    iconAnimationType: AnimationType.onHover,
                                    styleAnimationType: AnimationType.onHover,
                                    spacing: 2.0,
                                    customSeparatorBuilder:
                                        (context, local, global) {
                                      final opacity =
                                          ((global.position - local.position)
                                                      .abs() -
                                                  0.5)
                                              .clamp(0.0, 1.0);
                                      return VerticalDivider(
                                          indent: 10.0,
                                          endIndent: 10.0,
                                          color: Colors.white38
                                              .withOpacity(opacity));
                                    },
                                    customIconBuilder:
                                        (context, local, global) {
                                      final text = const [
                                        'Sign Up',
                                        'Log In',
                                      ][local.index];
                                      return Center(
                                        child: Text(
                                          text,
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            letterSpacing: 0.25,
                                            color: Color.lerp(
                                                kPrimaryBlueColor,
                                                Colors.white,
                                                local.animationValue),
                                          ),
                                        ),
                                      );
                                    },
                                    borderWidth: 1.0,
                                    onChanged: (i) => setState(() {
                                      value = i;
                                      if (value == 1) {
                                        ShowLoginView();
                                      } else {
                                        ();
                                        ShowSignUpView();
                                      }
                                    }),
                                  ),
                                ],
                              ),
                            ), // This trailing comma makes auto-formatting nicer for build methods.
                          ),

                          SizedBox(
                            height: 8.h,
                          ),
                          // CustomTextFormFieldWidget(
                          //   controller: emailController,
                          //   hint: 'Enter email or username',
                          //   keyboardType: TextInputType.emailAddress,
                          //   autofillHints: const [AutofillHints.email],
                          //   validator: (value) {
                          //     if (value == null || value.isEmpty) {
                          //       return 'please enter the email';
                          //     }
                          //     // else if (!EmailValidator.validate(value)) {
                          //     //   return 'please enter a valid email';
                          //     // }
                          //     return null;
                          //   },
                          // ),
                          // SizedBox(
                          //   height: 10.h,
                          // ),
                          // CustomTextFormFieldWidget(
                          //   controller: passwordController,
                          //   hint: 'Enter password',
                          //   keyboardType: TextInputType.emailAddress,
                          //   autofillHints: const [AutofillHints.email],
                          //   validator: (value) {
                          //     if (value == null || value.isEmpty) {
                          //       return 'please enter the password';
                          //     }
                          //     return null;
                          //   },
                          // ),
                          // SizedBox(
                          //   height: 10.h,
                          // ),
                          // showSignUp == true
                          //     ? CustomTextFormFieldWidget(
                          //         controller: confirmPasswordController,
                          //         hint: 'Confirm password',
                          //         keyboardType: TextInputType.emailAddress,
                          //         autofillHints: const [AutofillHints.email],
                          //         validator: (value) {
                          //           if (value == null || value.isEmpty) {
                          //             return 'please enter the password again';
                          //           }
                          //           return null;
                          //         },
                          //       )
                          //     : SizedBox(),
                          // // Opacity(
                          // //   opacity: showSignUp == true ? 1 : 0,
                          // //   child: CustomTextFormFieldWidget(
                          // //     controller: confirmPasswordController,
                          // //     hint: 'Confirm password',
                          // //     keyboardType: TextInputType.emailAddress,
                          // //     autofillHints: const [AutofillHints.email],
                          // //     validator: (value) {
                          // //       if (value == null || value.isEmpty) {
                          // //         return 'please enter the password again';
                          // //       }
                          // //       return null;
                          // //     },
                          // //   ),
                          // // ),
                          // SizedBox(
                          //   height: 40.h,
                          // ),
                          // CustomAuthButtonWidget(
                          //     title: showSignUp == true ? 'SIGN UP' : 'LOG IN'),
                          AnimatedSwitcher(
                            duration: Duration(
                                milliseconds: 500), // Set animation duration
                            child: showSignUp
                                ? buildSignUpView()
                                : buildLoginView(),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            'OR',
                            style: GoogleFonts.poppins(
                                color: Color(0xFFA8A7A7),
                                fontSize: 14,
                                letterSpacing: 0.25),
                          ),
                          const SizedBox(
                            height: 8,
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

  Widget buildSignUpView() {
    return Column(
      children: [
        CustomTextFormFieldWidget(
          controller: nameController,
          hint: 'Enter name',
          keyboardType: TextInputType.emailAddress,
          autofillHints: const [AutofillHints.email],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'please enter the name';
            }
            // else if (!EmailValidator.validate(value)) {
            //   return 'please enter a valid email';
            // }
            return null;
          },
        ),
        SizedBox(
          height: 8.h,
        ),
        CustomTextFormFieldWidget(
          controller: emailController,
          hint: 'Enter email or username',
          keyboardType: TextInputType.emailAddress,
          autofillHints: const [AutofillHints.email],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'please enter the email';
            }
            // else if (!EmailValidator.validate(value)) {
            //   return 'please enter a valid email';
            // }
            return null;
          },
        ),
        SizedBox(
          height: 8.h,
        ),
        CustomTextFormFieldWidget(
          controller: passwordController,
          hint: 'Enter password',
          keyboardType: TextInputType.emailAddress,
          autofillHints: const [AutofillHints.email],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'please enter the password';
            }
            return null;
          },
        ),
        SizedBox(
          height: 8.h,
        ),
        CustomTextFormFieldWidget(
          controller: confirmPasswordController,
          hint: 'Confirm password',
          keyboardType: TextInputType.emailAddress,
          autofillHints: const [AutofillHints.email],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'please enter the password again';
            }
            return null;
          },
        ),
        SizedBox(
          height: 40.h,
        ),
        CustomAuthButtonWidget(title: 'SIGN UP'),
      ],
    );
  }

  Widget buildLoginView() {
    return Column(
      children: [
        CustomTextFormFieldWidget(
          controller: emailController,
          hint: 'Enter email or username',
          keyboardType: TextInputType.emailAddress,
          autofillHints: const [AutofillHints.email],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'please enter the email';
            }
            // else if (!EmailValidator.validate(value)) {
            //   return 'please enter a valid email';
            // }
            return null;
          },
        ),
        SizedBox(
          height: 8.h,
        ),
        CustomTextFormFieldWidget(
          controller: passwordController,
          hint: 'Enter password',
          keyboardType: TextInputType.emailAddress,
          autofillHints: const [AutofillHints.email],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'please enter the password';
            }
            return null;
          },
        ),
        SizedBox(
          height: 8.h,
        ),
        SizedBox(
          height: 40.h,
        ),
        CustomAuthButtonWidget(title: 'LOG IN'),
      ],
    );
  }
}
