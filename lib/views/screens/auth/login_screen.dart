import 'package:consulting_app_pailmail/views/widgets/custom_rounded_rectangle_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/helpers/constants.dart';
import '../../widgets/custom_auth_button_widget.dart';
import '../../widgets/custom_auth_toggle_widget.dart';
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

  late bool showSignUp;
  late bool showLogin;

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
                    SizedBox(
                      height: 200.h,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 48, vertical: 66),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 31, vertical: 10),
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
                          CustomRoundedRectangleWidget(
                            child: Row(
                              children: [
                                CustomAuthToggleWidget(
                                    fontColor: showLogin == true
                                        ? kPrimaryBlueColor
                                        : kDarkGreyColor,
                                    text: 'Log In',
                                    onTap: ShowLoginView),
                                CustomAuthToggleWidget(
                                    fontColor: showLogin == true
                                        ? kDarkGreyColor
                                        : kPrimaryBlueColor,
                                    text: 'Sign Up',
                                    onTap: ShowSignUpView),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
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
                            height: 10.h,
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
                            height: 10.h,
                          ),
                          showSignUp == true
                              ? CustomTextFormFieldWidget(
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
                                )
                              : SizedBox(),
                          // Opacity(
                          //   opacity: showSignUp == true ? 1 : 0,
                          //   child: CustomTextFormFieldWidget(
                          //     controller: confirmPasswordController,
                          //     hint: 'Confirm password',
                          //     keyboardType: TextInputType.emailAddress,
                          //     autofillHints: const [AutofillHints.email],
                          //     validator: (value) {
                          //       if (value == null || value.isEmpty) {
                          //         return 'please enter the password again';
                          //       }
                          //       return null;
                          //     },
                          //   ),
                          // ),
                          SizedBox(
                            height: 40.h,
                          ),
                          CustomAuthButtonWidget(
                              title: showSignUp == true ? 'SIGN UP' : 'LOG IN'),
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
                            height: 12,
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
