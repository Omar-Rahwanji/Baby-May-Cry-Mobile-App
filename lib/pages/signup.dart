import '../components/custom_text_field.dart';
import '../services/auth.dart';
import '../static/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  bool showSpinner = false;

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    password.dispose();
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
                        SizedBox(height: screenheight * 0.1),
                        Text(
                          "Sign up".tr(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                          ),
                        ),
                        SizedBox(height: screenheight * 0.01),
                        SizedBox(
                          width: screenWidth * 0.7,
                          child: Text(
                            "Welcome. Register now, because your baby may cry!"
                                .tr(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                        SizedBox(height: screenheight * 0.05),
                        CustomTextField(
                          controller: firstName,
                          inputType: TextInputType.name,
                          hint: "First Name".tr(),
                          isObsecured: false,
                          isCenteredInput: false,
                          maxLength: 20,
                          icon: Icons.person_outlined,
                        ),
                        SizedBox(height: screenheight * 0.025),
                        CustomTextField(
                          controller: lastName,
                          inputType: TextInputType.name,
                          hint: "Last Name".tr(),
                          isObsecured: false,
                          isCenteredInput: false,
                          maxLength: 20,
                          icon: Icons.person_outlined,
                        ),
                        SizedBox(height: screenheight * 0.025),
                        CustomTextField(
                          controller: email,
                          inputType: TextInputType.emailAddress,
                          hint: "Email".tr(),
                          isObsecured: false,
                          isCenteredInput: false,
                          maxLength: 50,
                          icon: Icons.email_outlined,
                        ),
                        SizedBox(height: screenheight * 0.025),
                        CustomTextField(
                          controller: password,
                          inputType: TextInputType.text,
                          hint: "Password".tr(),
                          isObsecured: true,
                          isCenteredInput: false,
                          maxLength: 50,
                          icon: Icons.lock,
                        ),
                        SizedBox(height: screenheight * 0.025),
                        MaterialButton(
                          child: Text(
                            "Sign up".tr(),
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

                              Map<String, String> userData = {
                                'email': email.text,
                                'fullName':
                                    firstName.text + ' ' + lastName.text,
                              };
                              if (await AuthService.signup(
                                  userData, password.text)) {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, "/home", (route) => false,
                                    arguments: {
                                      'email': userData['email'],
                                      'fullName': userData['fullName']
                                    });
                              } else {
                                Fluttertoast.showToast(
                                  msg: 'Registeration failed, please try again',
                                  backgroundColor: Colors.red,
                                );
                              }

                              setState(() {
                                showSpinner = false;
                              });
                            }
                          },
                        ),
                        SizedBox(height: screenheight * 0.025),
                        Row(
                          textDirection: (translator.activeLanguageCode == "en")
                              ? TextDirection.ltr
                              : TextDirection.rtl,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text("Already have account?".tr()),
                            SizedBox(width: screenWidth * 0.02),
                            InkWell(
                                child: Text(
                                  "Login".tr(),
                                  style: TextStyle(
                                    color: CustomColors.primary,
                                    fontSize: 18,
                                  ),
                                ),
                                onTap: () => Navigator.pushNamedAndRemoveUntil(
                                    context, "/login", (route) => false)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: screenheight * 0.076),
                      child: Image(
                        image: const AssetImage("assets/images/border.png"),
                        fit: BoxFit.fill,
                        width: screenWidth,
                        height: translator.activeLanguageCode == "en"
                            ? screenheight * 0.201
                            : screenheight * 0.197,
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
