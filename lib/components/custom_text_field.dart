import '../static/colors.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    required this.controller,
    required this.inputType,
    required this.hint,
    required this.isObsecured,
    required this.isCenteredInput,
    required this.maxLength,
    required this.icon,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType inputType;
  final String hint;
  final bool isObsecured;
  final bool isCenteredInput;
  final int maxLength;
  final IconData icon;
  final List<TextAlign> textAlign = [TextAlign.left, TextAlign.right];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 40,
            ),
          ],
        ),
        child: TextFormField(
          style: TextStyle(
            color: CustomColors.primary,
          ),
          keyboardType: inputType,
          controller: controller,
          obscureText: isObsecured,
          textAlign: maxLength == 1
              ? TextAlign.center
              : textAlign[(translator.activeLanguageCode == "en") ? 0 : 1],
          maxLength: maxLength,
          textInputAction: TextInputAction.next,
          onChanged: (maxLength == 1)
              ? (_) {
                  if (controller.text.isNotEmpty) {
                    FocusScope.of(context).nextFocus();
                  }
                }
              : null,
          decoration: InputDecoration(
            prefixIcon: (maxLength > 1) ? Icon(icon) : null,
            counterText: "",
            filled: true,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            fillColor: Colors.white,
            hintText: hint,
            hintStyle: TextStyle(color: CustomColors.secondary),
            contentPadding: const EdgeInsets.fromLTRB(
              10.0,
              10.0,
              10.0,
              10.0,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(
                color: Colors.white,
                width: 3.0,
              ),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) return "Value shouldn't be empty".tr();
            String hint = this.hint.tr();
            if ((hint == "First Name".tr() || hint == "Last Name".tr()) &&
                value.length < 3) {
              return "Value shouldn't be less than 3 characters".tr();
            }
            if ((hint == "First name".tr() || hint == "Last name".tr()) &&
                value.startsWith(RegExp(r"^[0-9]"))) {
              return "Value shouldn't start with number".tr();
            }

            if (hint == "Email".tr() &&
                !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                    .hasMatch(value)) {
              return "Enter a valid email".tr();
            }
          },
        ),
      ),
    );
  }
}
