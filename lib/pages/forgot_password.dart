import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/custom_text_field.dart';
import '../services/auth.dart';

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
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: screenWidth * 0.8,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      margin: const EdgeInsets.only(bottom: 20),
                      child: const Hero(
                        tag: "logo",
                        child: Image(
                          image: AssetImage("assets/images/logo.png"),
                        ),
                      ),
                    ),
                    Text(
                      "Reset Password".tr(),
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                      ),
                    ),
                    const SizedBox(height: 25),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: email,
                      inputType: TextInputType.emailAddress,
                      hint: "Email".tr(),
                      isObsecured: false,
                      isCenteredInput: false,
                      maxLength: 50,
                      icon: Icons.email_outlined,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
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
                              msg: 'Please enter a valid email and try again'
                                  .tr(),
                              backgroundColor: Colors.red,
                            );
                          }

                          setState(() {
                            showSpinner = false;
                          });
                        }
                      },
                      child: Text(
                        "Reset".tr(),
                        textDirection: TextDirection.rtl,
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
