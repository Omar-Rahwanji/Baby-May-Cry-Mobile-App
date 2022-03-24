import '../components/custom-text-field.dart';
import '../services/auth.dart';
import '../services/db.dart';
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
                      "Sign up".tr(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                      ),
                    ),
                    const SizedBox(height: 25),
                    CustomTextField(
                      controller: firstName,
                      inputType: TextInputType.name,
                      hint: "First Name".tr(),
                      isObsecured: false,
                      isCenteredInput: false,
                      maxLength: 20,
                      icon: Icons.person_outlined,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: lastName,
                      inputType: TextInputType.name,
                      hint: "Last Name".tr(),
                      isObsecured: false,
                      isCenteredInput: false,
                      maxLength: 20,
                      icon: Icons.person_outlined,
                    ),
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
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: password,
                      inputType: TextInputType.text,
                      hint: "Password".tr(),
                      isObsecured: true,
                      isCenteredInput: false,
                      maxLength: 50,
                      icon: Icons.lock,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          print("validating");
                          setState(() {
                            showSpinner = true;
                          });

                          Map<String, String> userData = {
                            'email': email.text,
                            'fullName': firstName.text + ' ' + lastName.text,
                          };
                          if (await AuthService.signup(
                              userData, password.text)) {
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/home", (route) => false, arguments: {
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
                      child: Text("Sign up".tr()),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 12),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      textDirection: (translator.activeLanguageCode == "en")
                          ? TextDirection.ltr
                          : TextDirection.rtl,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text("HaveAccount".tr()),
                        const SizedBox(width: 8),
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
          ),
        ),
      ),
    );
  }
}
