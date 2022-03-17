import 'package:baby_may_cry/services/auth.dart';
import 'package:baby_may_cry/static/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class CustomPhoneField extends StatelessWidget {
  CustomPhoneField({Key? key, required this.controller}) : super(key: key);
  final List<TextAlign> phoneTextAlign = [TextAlign.left, TextAlign.right];
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.grey, blurRadius: 20, offset: const Offset(0, 10))
        ]),
        child: Container(
          child: IntlPhoneField(
            initialCountryCode: "US",
            controller: this.controller,
            invalidNumberMessage: "Invalid mobile number".tr(),
            textAlign: this.phoneTextAlign[
                (translator.activeLanguageCode == "en") ? 0 : 1],
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.phone),
              counterText: "",
              filled: true,
              fillColor: Colors.white,
              hintText: "Mobile Number".tr(),
              hintStyle: TextStyle(color: CustomColors.secondary),
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              contentPadding: const EdgeInsets.fromLTRB(
                10.0,
                10.0,
                10.0,
                10.0,
              ),
            ),
            onChanged: (phone) {
              print(phone.completeNumber);
              AuthService.phoneNumber = phone.completeNumber;
            },
            onCountryChanged: (country) {
              print('Country changed to: ' + country.name);
            },
            validator: (value) {
              if (value!.isEmpty) return "Value shouldn't be empty".tr();
            },
          ),
        ),
      ),
    );
  }
}
