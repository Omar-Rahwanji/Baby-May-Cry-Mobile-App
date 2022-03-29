import 'package:baby_may_cry/static/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../components/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final email = TextEditingController();
  final password = TextEditingController();
  late List<bool> isSelected = List.generate(2, (index) => false);
  bool showSpinner = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
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
                            height: screenheight * 0.1,
                          ),
                          ToggleButtons(
                              selectedColor: CustomColors.primary,
                              children: const [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Text("العربية"),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Text("English"),
                                ),
                              ],
                              isSelected: isSelected,
                              onPressed: (index) {
                                setState(() {
                                  isSelected[index] = !isSelected[index];
                                });

                                translator.setNewLanguage(
                                  context,
                                  newLanguage:
                                      translator.activeLanguageCode == "en"
                                          ? "ar"
                                          : "en",
                                  remember: true,
                                  restart: true,
                                );
                              }),
                          SizedBox(height: screenheight * 0.03),
                          Text(
                            "Login".tr(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 32,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: screenheight * 0.01),
                          SizedBox(
                            width: screenWidth * 0.7,
                            child: Text(
                              "Welcome back. Hurry up, your baby may cry!".tr(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                          SizedBox(height: screenheight * 0.1),
                          CustomTextField(
                            controller: email,
                            inputType: TextInputType.emailAddress,
                            hint: "Email".tr(),
                            isObsecured: false,
                            isCenteredInput: false,
                            maxLength: 50,
                            icon: Icons.email_outlined,
                          ),
                          const SizedBox(height: 25),
                          CustomTextField(
                            controller: password,
                            inputType: TextInputType.text,
                            hint: "Password".tr(),
                            isObsecured: true,
                            isCenteredInput: false,
                            maxLength: 50,
                            icon: Icons.lock,
                          ),
                          const SizedBox(height: 5),
                          Align(
                            alignment: translator.activeLanguageCode == 'en'
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: InkWell(
                              child: Text(
                                "Forgot your password?".tr(),
                                textDirection:
                                    (translator.activeLanguageCode == "en")
                                        ? TextDirection.ltr
                                        : TextDirection.rtl,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: CustomColors.primary,
                                    fontSize: 18,
                                    decoration: TextDecoration.underline),
                              ),
                              onTap: () => Navigator.pushNamed(
                                  context, "/forgot-password"),
                            ),
                          ),
                          const SizedBox(height: 35),
                          MaterialButton(
                            child: Text(
                              "Login".tr(),
                              style: TextStyle(fontSize: 20),
                            ),
                            color: CustomColors.primary,
                            textColor: Colors.white,
                            minWidth: screenWidth * 0.9,
                            padding: EdgeInsets.all(12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22)),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  showSpinner = true;
                                });

                                bool isLoggedIn = await AuthService.login(
                                    email.text, password.text);

                                setState(() {
                                  showSpinner = false;
                                });
                                if (isLoggedIn) {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  Navigator.pushReplacementNamed(
                                      context, "/home", arguments: {
                                    'email': prefs.getString('email'),
                                    'fullName': prefs.getString('fullName')
                                  });
                                } else {
                                  password.clear();
                                  Fluttertoast.showToast(
                                    msg: "Failed logging in, please try again"
                                        .tr(),
                                    backgroundColor: Colors.red,
                                  );
                                }
                              }
                            },
                          ),
                          const SizedBox(height: 25),
                          Row(
                            textDirection:
                                (translator.activeLanguageCode == "en")
                                    ? TextDirection.ltr
                                    : TextDirection.rtl,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text("Don't have an account?".tr()),
                              const SizedBox(width: 8),
                              InkWell(
                                child: Text(
                                  "Sign up now".tr(),
                                  style: TextStyle(
                                    color: CustomColors.primary,
                                    fontSize: 18,
                                  ),
                                ),
                                onTap: () =>
                                    Navigator.pushNamed(context, "/sign-up"),
                              ),
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
                        margin: const EdgeInsets.only(top: 30),
                        child: Image(
                          image: const AssetImage("assets/images/border.png"),
                          fit: BoxFit.fill,
                          width: screenWidth,
                          height: 157,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        child: Hero(
                          tag: "logo",
                          child: Image(
                            image: const AssetImage("assets/images/logo.png"),
                            width: screenWidth * 0.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
