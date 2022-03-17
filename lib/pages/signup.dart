
import 'package:baby_may_cry/components/custom-phone-field.dart';
import 'package:baby_may_cry/components/custom-text-field.dart';
import 'package:baby_may_cry/services/auth.dart';
import 'package:baby_may_cry/services/db.dart';
import 'package:baby_may_cry/static/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  GlobalKey<FormState> _formKey = GlobalKey();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phoneNumber = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  bool showSpinner = false;

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    phoneNumber.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: this.showSpinner,
        child: Container(
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                width: screenWidth * 0.8,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        margin: EdgeInsets.only(bottom: 20),
                        child: Hero(
                          tag: "logo",
                          child: Image(
                            image: AssetImage("assets/images/logo.png"),
                          ),
                        ),
                      ),
                      Text(
                        "Sign up".tr(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                        ),
                      ),
                      SizedBox(height: 25),
                      CustomTextField(
                        controller: firstName,
                        inputType: TextInputType.name,
                        hint: "First Name".tr(),
                        isObsecured: false,
                        isCenteredInput: false,
                        maxLength: 20,
                        icon: Icons.person_outlined,
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        controller: lastName,
                        inputType: TextInputType.name,
                        hint: "Last Name".tr(),
                        isObsecured: false,
                        isCenteredInput: false,
                        maxLength: 20,
                        icon: Icons.person_outlined,
                      ),
                      SizedBox(height: 20),
                      CustomPhoneField(controller: this.phoneNumber),
                      SizedBox(height: 20),
                      CustomTextField(
                        controller: email,
                        inputType: TextInputType.emailAddress,
                        hint: "Email".tr(),
                        isObsecured: false,
                        isCenteredInput: false,
                        maxLength: 50,
                        icon: Icons.email_outlined,
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate() &&
                              this.phoneNumber.text.isNotEmpty) {
                            print("validating");
                            setState(() {
                              this.showSpinner = true;
                            });

                            AuthService.authState = "signup";
                            FirestoreDb.userData = {
                              "firstName": firstName.text,
                              "lastName": lastName.text,
                              "phoneNumber": AuthService.phoneNumber,
                              "email": email.text,
                            };
                            await AuthService.signup(context);
                            // .then((value) {
                            //   if (AuthService.isLogged != true)
                            //     Fluttertoast.showToast(
                            //       msg: "Failed signing up, please try again"
                            //           .tr(),
                            //       backgroundColor: Colors.red,
                            //     );
                            // });

                            setState(() {
                              this.showSpinner = false;
                            });
                          } else
                            Fluttertoast.showToast(
                              msg: "Please fill all fields".tr(),
                              backgroundColor: Colors.red,
                            );
                        },
                        child: Text("Sign up".tr()),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(40),
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 12),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        textDirection: (translator.activeLanguageCode == "en")
                            ? TextDirection.ltr
                            : TextDirection.rtl,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text("HaveAccount".tr()),
                          SizedBox(width: 8),
                          InkWell(
                            child: Text(
                              "Login".tr(),
                              style: TextStyle(
                                color: CustomColors.primary,
                                fontSize: 18,
                              ),
                            ),
                            onTap: () => Navigator.pushNamed(context, "/login"),
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
