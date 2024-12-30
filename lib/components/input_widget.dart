import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_farm_application/utilities/string-utils.dart';

import '../utilities/size_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InputWidget extends StatefulWidget {
  const InputWidget(
      {super.key,
      required this.hintText,
      this.isObscureText = false,
      this.isDisable = false,
      required this.label,
      required this.controller,
      this.compulsory = false,
      this.number = false,
      this.maxlength = 0,
      this.multiText = false,
      this.isLargeInput = false,
      this.checkValidate = false,
      this.isSuffix,
      this.isEmail = false});
  final String label;
  final TextEditingController controller;
  final String hintText;
  final bool compulsory; // Indicates if the field is mandatory
  final bool number; // Indicates if the field is for numeric input
  final int maxlength;
  final bool multiText; // Indicates if the field allows multiple lines
  final bool isLargeInput;
  final bool isObscureText;
  final bool isDisable;
  final bool isEmail;
  final bool checkValidate;
  final Widget? isSuffix;

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  bool isShadow = false;
  @override
  Widget build(BuildContext context) {
    FocusNode focusNode = FocusNode();
    SizeUtils sizeUtils = SizeUtils(context);
    return InkWell(
      focusColor: Colors.white,
      splashColor: Colors.transparent,
      focusNode: focusNode,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label.isNotEmpty)
            const SizedBox(
              height: 20,
            ),
          Text.rich(
            TextSpan(
              text: '${widget.label} ',
              children: [
                if (widget.compulsory)
                  const TextSpan(
                    text: '*',
                    style: TextStyle(color: Colors.red),
                  )
              ],
            ),
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: sizeUtils.subTitleFontSize,
                fontFamily: 'Roboto'),
          ),
          const SizedBox(
            height: 10,
          ),
          Material(
            borderRadius: BorderRadius.circular(sizeUtils.borderRadiusInput),
            color: Colors.white,
            borderOnForeground: true,
            elevation: isShadow ? 0 : 5,
            shadowColor: Colors.grey.withOpacity(0.5),
            child: TextFormField(
              obscureText: widget.isObscureText,
              enabled: !widget.isDisable,
              readOnly: widget.isDisable,
              validator: (value) {
                if ((value == null || value.isEmpty) && widget.checkValidate) {
                  setState(() {
                    isShadow = true;
                  });
                  return AppLocalizations.of(context)!.strNotEmpty;
                } else if (widget.isEmail &&
                    !StringUtils.isEmail(value ?? "")) {
                  setState(() {
                    isShadow = true;
                  });
                  return AppLocalizations.of(context)!.inValidEmail;
                }
                setState(() {
                  isShadow = false;
                });
                return null;
              },
              cursorColor: const Color(0xFF0B4DA3),
              maxLength: widget.maxlength == 0 ? null : widget.maxlength,
              buildCounter: (BuildContext context,
                      {int? currentLength, int? maxLength, bool? isFocused}) =>
                  null,
              inputFormatters: [
                if (widget.number)
                  FilteringTextInputFormatter.digitsOnly
                else
                  FilteringTextInputFormatter.singleLineFormatter
              ],
              keyboardType: widget.isEmail
                  ? TextInputType.emailAddress
                  : widget.number
                      ? TextInputType.number
                      : (widget.multiText
                          ? TextInputType.multiline
                          : TextInputType.text),
              maxLines: widget.multiText ? null : 1,
              controller: widget.controller,
              decoration: InputDecoration(
                suffixIcon: widget.isSuffix,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFF4B4B4B)),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                hintText: widget.hintText,
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFB3B3B3),
                    fontSize: sizeUtils.subTitleFontSize,
                    fontFamily: 'Roboto'),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(sizeUtils.borderRadiusInput),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFFE8E8E8), width: 2.0),
                  borderRadius:
                      BorderRadius.circular(sizeUtils.borderRadiusInput),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 2.0),
                  borderRadius:
                      BorderRadius.circular(sizeUtils.borderRadiusInput),
                ),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 10, vertical: widget.isLargeInput ? 200 : 12),
                errorStyle: TextStyle(
                    color: Colors.red, fontSize: sizeUtils.errorFontSize),
              ),
              textAlign: TextAlign.start,
              // style: _sizeUtils.subtitle.copyWith(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
