import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/custom_text_field.dart';
import '../services/auth.dart';
import '../static/colors.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final email = TextEditingController();

  bool showSpinner = false;

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: screenWidth * 0.8,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: translator.activeLanguageCode == "ar"
                              ? screenheight * 0.12
                              : screenheight * 0.12,
                        ),
                        Text(
                          "Reset Password".tr(),
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                          ),
                        ),
                        SizedBox(height: screenheight * 0.01),
                        SizedBox(
                          width: screenWidth * 0.7,
                          child: Text(
                            "Hurry up, your baby may cry!".tr(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                        SizedBox(height: screenheight * 0.25),
                        CustomTextField(
                          controller: email,
                          inputType: TextInputType.emailAddress,
                          hint: "Email".tr(),
                          isObsecured: false,
                          isCenteredInput: false,
                          maxLength: 50,
                          icon: Icons.email_outlined,
                        ),
                        SizedBox(height: screenheight * 0.02),
                        MaterialButton(
                          child: Text(
                            "Reset".tr(),
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(fontSize: 20),
                          ),
                          color: CustomColors.primary,
                          textColor: Colors.white,
                          minWidth: screenWidth * 0.9,
                          padding: EdgeInsets.all(screenheight * 0.016),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22.0)),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              print("validating");
                              setState(() {
                                showSpinner = true;
                              });

                              if (await AuthService.resetPassword(email.text)) {
                                Fluttertoast.showToast(
                                  msg:
                                      'A link for resetting password has been sent succefully to the email'
                                          .tr(),
                                  backgroundColor: Colors.green,
                                );

                                Navigator.pushNamedAndRemoveUntil(
                                    context, "/login", (route) => false);
                              } else {
                                Fluttertoast.showToast(
                                  msg:
                                      'Please enter a valid email and try again'
                                          .tr(),
                                  backgroundColor: Colors.red,
                                );
                              }

                              setState(() {
                                showSpinner = false;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: translator.activeLanguageCode == "en"
                            ? screenheight * 0.199
                            : screenheight * 0.199,
                      ),
                      child: Image(
                        image: const AssetImage("assets/images/border.png"),
                        fit: BoxFit.fill,
                        width: screenWidth,
                        height: screenheight * 0.201,
                      ),
                    ),
                    Hero(
                      tag: "logo",
                      child: Image(
                        image: const AssetImage("assets/images/logo.png"),
                        width: screenWidth * 0.4,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
