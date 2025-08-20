import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:taxi_driver/core/constants/app_colors.dart';

class PhonePickerField extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final TextInputType keyboardType;
  final int maxLines;
  final bool isPassword;
  final bool enable;
  final Widget? suffixIcon;
  final Widget? preffixIcon;
  final EdgeInsets? padding;
  final bool hasSuffix;
  final bool hasPreffix;
  final bool hasTopIcon;
  final int? maxLength;
  final Color suffixIconColor;
  final double suffixIconSize;
  final Color preffixIconColor;
  final double preffixIconSize;
  final VoidCallback? suffixIconFunction;
  final Color themeColor;
  final Color backcolor;
  final bool enabledBorder;
  final void Function(String fullPhone)? onChange;      // returns full phone number
  final void Function(String fullPhone)? onComplete;
  final void Function(String? fullPhone)? onSaved;
  final void Function(String dialCode)? onDialCodeChanged; // <-- NEW callback for dialCode
  final VoidCallback? onEditingComplete;
  final double? textFieldheight;
  final TextAlign? textAlign;
  final String lable;
  final String? isoCode;
  double? width;

  PhonePickerField({
    Key? key,
    this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.phone,
    this.isPassword = false,
    this.enable = true,
    this.suffixIcon,
    this.width,
    this.enabledBorder = false,
    this.suffixIconFunction,
    this.lable = '',
    this.hasSuffix = false,
    this.hasPreffix = true,
    this.backcolor = Colors.transparent,
    this.themeColor = AppColors.primarybluecolor,
    this.suffixIconColor = Colors.white,
    this.suffixIconSize = 20,
    this.preffixIconColor = Colors.white,
    this.preffixIconSize = .06,
    this.onChange,
    this.onComplete,
    this.preffixIcon,
    this.onSaved,
    this.onEditingComplete,
    this.maxLines = 1,
    this.padding,
    this.hasTopIcon = false,
    this.maxLength,
    this.textFieldheight,
    this.textAlign,
    this.isoCode,
    this.onDialCodeChanged, // optional
  }) : super(key: key);

  @override
  State<PhonePickerField> createState() => _PhonePickerFieldState();
}

class _PhonePickerFieldState extends State<PhonePickerField> {
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 56.w,
          width: widget.width ?? 310.w,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: InternationalPhoneNumberInput(
            onInputChanged: (PhoneNumber number) {
              // return full phone number
              widget.onChange?.call(number.phoneNumber ?? '');

              // return dialCode separately
              widget.onDialCodeChanged?.call(number.dialCode ?? '');
            },

            selectorConfig: const SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              useBottomSheetSafeArea: true,
              showFlags: true,
              setSelectorButtonAsPrefixIcon: true,
              leadingPadding: 0,
            ),

            autoValidateMode: AutovalidateMode.disabled,
            selectorTextStyle: TextStyle(
              color: AppColors.primarybackColor.withOpacity(0.8),
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
              fontFamily: 'Poppins',
            ),
            textStyle: TextStyle(
              color: AppColors.primarybackColor.withOpacity(0.8),
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
              fontFamily: 'Poppins',
            ),
            initialValue: PhoneNumber(isoCode: widget.isoCode ?? 'NG'),
            textFieldController: widget.controller,
            keyboardType: widget.keyboardType,

            inputDecoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Colors.white,
              filled: true,
              contentPadding: const EdgeInsets.only(left: 0, bottom: 0),
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: AppColors.primarybackColor.withOpacity(0.8),
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                fontFamily: 'Poppins',
              ),
              suffixIcon: widget.hasSuffix
                  ? InkWell(
                      onTap: widget.suffixIconFunction,
                      child: widget.suffixIcon ?? const Icon(Icons.phone),
                    )
                  : const SizedBox(),
              isDense: true,
            ),

            onSaved: (PhoneNumber number) {
              widget.onSaved?.call(number.phoneNumber);
              widget.onDialCodeChanged?.call(number.dialCode ?? '');
            },

            validator: (value) {
              if (value == null || value.isEmpty) {
                setState(() {
                  error = 'Phone is required';
                });
                return null;
              } else {
                setState(() {
                  error = '';
                });
              }
              return null;
            },
            onFieldSubmitted: widget.onComplete,
            textAlign: widget.textAlign ?? TextAlign.start,
          ),
        ),
        error.isNotEmpty ? const SizedBox(height: 5) : const SizedBox.shrink(),
        error.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  error,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
