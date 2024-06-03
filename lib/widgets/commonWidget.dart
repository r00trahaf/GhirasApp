import 'package:flutter/material.dart';
import 'package:ghiras/widgets/AppDetails.dart';
import 'package:ghiras/widgets/commonColor.dart';

class CommonTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputAction? textInputAction;
  final String? Function(String? msg)? validator;
  final TextInputType? keyboardType;
  final int maxLength;
  final int? maxLines;
  final bool obscureText;
  final bool isReadyOnly;
  final Widget? suffixIcon;
  final Widget? suffix;
  final Decoration? decoration;
  void Function()? onTaps;
  void Function(String)? onChanged;
  String? suffixText;
  String? label;
  String hintTextColor;
  bool fillColor;
  String? fontFamily;
  TextAlign textAlign;

  CommonTextFormField({
    required this.textInputAction,
    required this.validator,
    this.textAlign = TextAlign.start,
    this.maxLength = 1024,
    required this.controller,
    this.hintTextColor = "000000",
    required this.hintText,
    this.fillColor = false,
    this.fontFamily = "Cairo-Medium",
    this.onTaps,
    this.onChanged,
    this.suffixIcon,
    this.isReadyOnly = false,
    this.obscureText = false,
    this.maxLines,
    required this.keyboardType,
    this.decoration,
    this.suffix,
    this.suffixText,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Material(
        elevation: 10.0,
        borderRadius: BorderRadius.circular(20),
        shadowColor: Colors.black,
        child: TextFormField(
          textAlign: textAlign,
          onTap: onTaps,
          readOnly: isReadyOnly,
          obscureText: obscureText,
          maxLength: maxLength,
          maxLines: maxLines,
          textAlignVertical:
          TextAlignVertical.top, // Align hint text vertically in the center
          textInputAction: textInputAction,
          validator: validator,
          controller: controller,
          style: TextStyle(
            fontFamily: AppDetails.cairoMedium,
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            color: CommonColor.blackColor,
          ),
          cursorColor: Colors.black,
          keyboardType: keyboardType,
          onChanged: onChanged,
          decoration: InputDecoration(
            filled: fillColor,
            fillColor: CommonColor.calendarLightColor,
            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: label,
            labelStyle: TextStyle(

              fontFamily: AppDetails.cairoRegular,
              fontSize: 17,
              color: CommonColor.checkedDarkColor,
            ),
            suffixText: suffixText,
            suffixIcon: suffixIcon,
            counterText: "",
            hintText: hintText!,
            hintStyle: TextStyle(
              fontFamily: fontFamily,
              color: Colors.grey,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: CommonColor.borderColor,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: CommonColor.blackColor,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: CommonColor.borderColor,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: CommonColor.borderColor,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: CommonColor.borderColor,
                width: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class textWidget extends StatelessWidget {
  String? text;
  FontWeight? fontWeight;
  double? fontSize;
  Color? color;
  String? fontFamily;
  int? maxLines;
  TextOverflow? overflow;
  TextAlign? textAlign;

  textWidget({
    this.text,
    this.fontWeight = FontWeight.normal,
    this.fontSize,
    this.maxLines = 2,
    this.color,
    this.fontFamily,
    this.overflow,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
        fontFamily: fontFamily,
        overflow: overflow,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}

class CommonButton extends StatelessWidget {
  void Function()? onPress;
  String text;
  double fontSize;
  double buttonHeight;
  double buttonWidth;
  Color? buttonColor;
  Color fontColor;
  String buttonFontFamily;
  FontWeight? fontWeight;
  BorderSide? borderSide;
  double borderRadius;
  double elevationValue;

  CommonButton({
    required this.onPress,
    required this.text,
    this.buttonHeight = 55.0,
    this.fontSize = 18.0,
    this.buttonWidth = 254,
    this.buttonColor,
    this.buttonFontFamily = "Cairo-ExtraBold",
    this.fontWeight,
    this.borderRadius = 20.0,
    this.fontColor = Colors.white,
    this.borderSide,
    this.elevationValue = 0.0
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight,
      width: buttonWidth,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: elevationValue,
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: (borderSide != null)
                  ? borderSide!
                  : BorderSide(color: CommonColor.buttonColor, width: 0),
            ),
          ),
          onPressed: onPress,
          child: textWidget(
            text: text,
            color: fontColor,
            fontWeight: fontWeight,
            fontSize: 16,
            fontFamily: AppDetails.cairoExtraBold,
          )),
    );
  }
}