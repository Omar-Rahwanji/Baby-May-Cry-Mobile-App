import 'package:baby_may_cry/components/custom-phone-field.dart';
import 'package:baby_may_cry/services/auth.dart';
import 'package:baby_may_cry/static/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formKey = GlobalKey();
  final phoneNumber = TextEditingController();
  late List<bool> isSelected;
  bool showSpinner = false;

  @override
  void initState() {
    super.initState();
    isSelected = [true, false];
    AuthService.resetAuth();
  }

  @override
  void dispose() {
    phoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: this.showSpinner,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                width: screenWidth * 0.8,
                child: Form(
                  key: this._formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: screenheight * 0.01,
                      ),
                      ToggleButtons(
                          selectedColor: CustomColors.primary,
                          disabledColor: Colors.white,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                              child: Text("العربية"),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                              child: Text("English"),
                            ),
                          ],
                          isSelected: this.isSelected,
                          onPressed: (index) {
                            for (int i = 0; i < isSelected.length; i++) {
                              isSelected[i] = i == index;
                            }
                            translator.setNewLanguage(
                              context,
                              newLanguage: translator.activeLanguageCode == "en"
                                  ? "ar"
                                  : "en",
                              remember: true,
                              restart: true,
                            );
                            setState(() {});
                          }),
                      SizedBox(height: screenheight * 0.1),
                      Container(
                        width: 150,
                        margin: EdgeInsets.only(bottom: 40),
                        child: Hero(
                          tag: "logo",
                          child: Image(
                            image: AssetImage("assets/images/logo.png"),
                          ),
                        ),
                      ),
                      Text(
                        "Login".tr(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: screenheight * 0.05),
                      CustomPhoneField(controller: phoneNumber),
                      SizedBox(height: 25),
                      ElevatedButton(
                        child: Text("Login".tr()),
                        onPressed: () async {
                          if (_formKey.currentState!.validate() &&
                              AuthService.phoneNumber.isNotEmpty) {
                            setState(() {
                              this.showSpinner = true;
                            });

                            AuthService.authState = "login";
                            await AuthService.login(context).then((value) {
                              if (AuthService.isLogged != true) {
                                Fluttertoast.showToast(
                                  msg: "Failed logging in, please try again"
                                      .tr(),
                                  backgroundColor: Colors.red,
                                );
                              }
                            });

                            setState(() {
                              showSpinner = false;
                            });
                          } else {
                            Fluttertoast.showToast(
                              msg: "Please fill all fields".tr(),
                              backgroundColor: Colors.red,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(40),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 12),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        textDirection: (translator.activeLanguageCode == "en")
                            ? TextDirection.ltr
                            : TextDirection.rtl,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text("noAccount".tr()),
                          const SizedBox(width: 8),
                          InkWell(
                            child: Text(
                              "SignNow".tr(),
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
            ),
          ),
        ),
      ),
    );
  }
}
