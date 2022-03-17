

import 'dart:async';

import 'package:baby_may_cry/components/custom-text-field.dart';
import 'package:baby_may_cry/services/auth.dart';
import 'package:baby_may_cry/static/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class OTPPage extends StatefulWidget {
  OTPPage({Key? key}) : super(key: key);

  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final otpNumber1 = TextEditingController();
  final otpNumber2 = TextEditingController();
  final otpNumber3 = TextEditingController();
  final otpNumber4 = TextEditingController();
  final otpNumber5 = TextEditingController();
  final otpNumber6 = TextEditingController();

  String verificationCode = '';
  final List<Alignment> textAlign = [
    Alignment.centerLeft,
    Alignment.centerRight
  ];
  bool showSpinner = false;
  int countDown = 120;

  void decreaseTime() {
    if (mounted) setState(() => this.countDown--);
  }

  @override
  void initState() {
    super.initState();
    countDown = 120;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (this.countDown == 0) {
        timer.cancel();
        AuthService.isExpiredOTP = true;
      } else
        decreaseTime();
    });
  }

  @override
  void dispose() {
    otpNumber1.dispose();
    otpNumber2.dispose();
    otpNumber3.dispose();
    otpNumber4.dispose();
    otpNumber5.dispose();
    otpNumber6.dispose();
    countDown = 120;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        child: Center(
          child: Container(
            width: screenWidth * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                  "Verification".tr(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                  ),
                ),
                SizedBox(height: screenheight * 0.05),
                Row(
                  children: [
                    Flexible(
                      child: CustomTextField(
                        controller: otpNumber1,
                        inputType: TextInputType.phone,
                        hint: "",
                        isObsecured: false,
                        isCenteredInput: true,
                        maxLength: 1,
                        icon: Icons.code,
                      ),
                    ),
                    SizedBox(width: 5),
                    Flexible(
                      child: CustomTextField(
                        controller: otpNumber2,
                        inputType: TextInputType.phone,
                        hint: "",
                        isObsecured: false,
                        isCenteredInput: true,
                        maxLength: 1,
                        icon: Icons.code,
                      ),
                    ),
                    SizedBox(width: 5),
                    Flexible(
                      child: CustomTextField(
                        controller: otpNumber3,
                        inputType: TextInputType.phone,
                        hint: "",
                        isObsecured: false,
                        isCenteredInput: true,
                        maxLength: 1,
                        icon: Icons.code,
                      ),
                    ),
                    SizedBox(width: 5),
                    Flexible(
                      child: CustomTextField(
                        controller: otpNumber4,
                        inputType: TextInputType.phone,
                        hint: "",
                        isObsecured: false,
                        isCenteredInput: true,
                        maxLength: 1,
                        icon: Icons.code,
                      ),
                    ),
                    SizedBox(width: 5),
                    Flexible(
                      child: CustomTextField(
                        controller: otpNumber5,
                        inputType: TextInputType.phone,
                        hint: "",
                        isObsecured: false,
                        isCenteredInput: true,
                        maxLength: 1,
                        icon: Icons.code,
                      ),
                    ),
                    SizedBox(width: 5),
                    Flexible(
                      child: CustomTextField(
                        controller: otpNumber6,
                        inputType: TextInputType.phone,
                        hint: "",
                        isObsecured: false,
                        isCenteredInput: true,
                        maxLength: 1,
                        icon: Icons.code,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  textDirection: (translator.activeLanguageCode == "en")
                      ? TextDirection.ltr
                      : TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Text(
                        "Resend a verification code".tr(),
                        style: TextStyle(
                          color: CustomColors.primary,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      onTap: () async {
                        String temp = AuthService.phoneNumber;
                        AuthService.resetAuth();
                        AuthService.phoneNumber = temp;
                        this.countDown = 10;
                        this.showSpinner = true;
                        if (mounted) setState(() {});

                        await AuthService.getOTP(context);

                        this.showSpinner = false;
                        if (mounted) setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.timer,
                          color: CustomColors.primary,
                        ),
                        SizedBox(width: 5),
                        Text(
                          this.countDown.toString(),
                          style: TextStyle(
                            color: CustomColors.primary,
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Divider(
                  thickness: 2,
                  color: CustomColors.secondary,
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () async {
                    //post phone number and password
                    if (otpNumber1.text.isEmpty ||
                        otpNumber2.text.isEmpty ||
                        otpNumber3.text.isEmpty ||
                        otpNumber4.text.isEmpty ||
                        otpNumber5.text.isEmpty ||
                        otpNumber6.text.isEmpty)
                      Fluttertoast.showToast(
                        msg: "Please fill all fields".tr(),
                        backgroundColor: Colors.red,
                      );
                    else {
                      verificationCode = otpNumber1.text +
                          otpNumber2.text +
                          otpNumber3.text +
                          otpNumber4.text +
                          otpNumber5.text +
                          otpNumber6.text;
                      otpNumber1.clear();
                      otpNumber2.clear();
                      otpNumber3.clear();
                      otpNumber4.clear();
                      otpNumber5.clear();
                      otpNumber6.clear();
                      this.showSpinner = true;
                      if (mounted) setState(() {});
                      await AuthService.verifyOTP(context, verificationCode);
                      this.showSpinner = false;
                      if (mounted) setState(() {});
                    }
                  },
                  child: Text("Verify".tr()),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(40),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
