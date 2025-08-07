import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi_driver/core/constants/app_colors.dart';
import 'package:taxi_driver/core/utils/app_constants.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
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
  final VoidCallback? onTap;
  final Color suffixIconColor;
  final double suffixIconSize;
  final Color preffixIconColor;
  final double preffixIconSize;
  final VoidCallback? suffixIconFunction;
  final Color themeColor;
  final Color backcolor;
  final String? Function(String?)? function;
  final String? Function(String?)? onChange;
  final String? Function(String?)? onComplete;
  final String? Function(String?)? onSaved;
  final String? Function()? onEditingComplete;
  double? textFieldheight;
  TextAlign? textAlign;
  final String? Function(String?)? validator;
  CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.keyboardType,
    this.isPassword = false,
    this.enable = true,
    this.suffixIcon,
    this.suffixIconFunction,
    this.function,
    this.hasSuffix = false,
    this.hasPreffix = true,
    this.backcolor = Colors.transparent,
    this.themeColor = AppColors.primaryappcolor,
    this.suffixIconColor = AppColors.primarybackColor,
    this.suffixIconSize = 25,
    this.preffixIconColor = AppColors.searchIconColor,
    this.preffixIconSize = 30,
    this.onChange,
    this.onTap,
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
    required textcolor,
    bool? obscureText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(vertical: 6),
      width: double.infinity,
      height: textFieldheight ?? 70,

      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(25.r),
      ),
      //  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        enabled: enable,

        controller: controller,
        maxLines: maxLines,
        onTap: onTap,
        textAlign: textAlign ?? TextAlign.start,
        textInputAction: TextInputAction.next,
        cursorColor: themeColor,
        // cursorWidth: 2.0,
        textAlignVertical: TextAlignVertical.center,
        maxLength: maxLength,
        // cursorHeight: kHeight(.024),
        obscureText: isPassword ? obscureText.value : defaultObscureText.value,
        obscuringCharacter: "*",
        keyboardType: keyboardType,
        onFieldSubmitted: onComplete,
        onChanged: onChange,
        onSaved: onSaved,
        onEditingComplete: onEditingComplete,
        inputFormatters: [
          if (keyboardType == TextInputType.phone)
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
          else
            FilteringTextInputFormatter.allow(
              RegExp(
                r'[a-zA-ZÀ-ÿ0-9 @/:?\-_.]',
              ), // Allows accented letters like é
            ),

          if (keyboardType == TextInputType.phone)
            FilteringTextInputFormatter.deny(
              RegExp(r'[\.,\-_]'),
            ) // Deny special characters in phone numbers
          else
            FilteringTextInputFormatter.deny(RegExp(r'[#]')), // Restrict #
        ],
        style: TextStyle(color: AppColors.headingcolor, fontSize: 16.sp),
        // validator: function,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: AppColors.primarybackColor.withOpacity(0.8),
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            fontFamily: 'Poppins',
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 13,
          ),
          fillColor: Colors.white,
          filled: true,

          // prefixIcon: Icon(Icons.search,size: preffixIconSize,color: preffixIconColor,),
          // suffixIcon: Icon(Icons.voice_over_off_outlined,size: suffixIconSize,color: suffixIconColor,),
          suffixIcon: hasSuffix ? suffixIcon : null,
          prefixIcon: hasPreffix ? preffixIcon : null,
          isDense: true,

// Enabled border (default border when not focused)
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.kformborderColor.withOpacity(0.5), // Light border
      width: 1,
    ),
    borderRadius: BorderRadius.circular(10.r),
  ),

  // Focused border (when field is active)
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.kformborderColor,
      width: 1.5,
    ),
    borderRadius: BorderRadius.circular(10.r),
  ),

  // Error border (when there's an error)
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(10.r),
  ),

  // Focused error border (when focused and error exists)
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red,
      width: 1.5,
    ),
    borderRadius: BorderRadius.circular(10.r),
  ),

  // Optional: default border fallback
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.r),
    borderSide: BorderSide(
      color: AppColors.kformborderColor.withOpacity(0.5),
      width: 1,
    ),
  ),
          // // disabledBorder: OutlineInputBorder(
          // //   borderSide: BorderSide(
          // //     // color: AppColors.greyColor.withOpacity(.6),
          // //     width: .5,
          // //     strokeAlign: BorderSide.strokeAlignInside,
          // //   ),
          // //   borderRadius: BorderRadius.circular(
          // //     10.r,
          // //   ),
          // // ),
          // // enabledBorder: OutlineInputBorder(
          // //   borderSide: BorderSide(
          // //     // color: AppColors.black1A.withOpacity(.6),
          // //     color: Colors.transparent,
          // //     width: .0,
          // //     strokeAlign: BorderSide.strokeAlignInside,
          // //   ),
          // //   borderRadius: BorderRadius.circular(
          // //     10.r,
          // //   ),
          // // ),
          // focusedBorder: OutlineInputBorder(
          //   borderSide:  BorderSide(
          //     color: AppColors.kformborderColor,
          //     width: 1,
          //     strokeAlign: BorderSide.strokeAlignInside,
          //   ),
          //   borderRadius: BorderRadius.circular(
          //     10.r,
          //   ),
          // ),
          // border: UnderlineInputBorder(
          //   borderSide: BorderSide(
          //     color: AppColors.grey,
          //     width: .0,
          //     strokeAlign: BorderSide.strokeAlignInside,
          //   ),
          //   borderRadius: BorderRadius.circular(
          //     10.r,
          //   ),
          // ),
          // // focusedErrorBorder: UnderlineInputBorder(
          // //   borderSide: const BorderSide(
          // //     color: Colors.grey,
          // //     width: .5,
          // //     strokeAlign: BorderSide.strokeAlignInside,
          // //   ),
          // //   borderRadius: BorderRadius.circular(10.r),
          // //   // gapPadding: 20,
          // // ),
          // errorBorder: OutlineInputBorder(
          //   borderSide: BorderSide(
          //     color: AppColors.kformborderColor,
          //     // color: Colors.black.withOpacity(.6),
          //     width: .5,
          //     strokeAlign: BorderSide.strokeAlignInside,
          //   ),
          //   borderRadius: BorderRadius.circular(10.r),
          // ),

          // // border: InputBorder.none,
          // // enabledBorder: UnderlineInputBorder(
          // //   borderSide: const BorderSide(color: Colors.grey),
          // // ),

          // // enabledBorder:
          // //     UnderlineInputBorder(borderRadius: BorderRadius.circular(20.r)),
        ),
      ),
    );
  }
}


class CustomSearchTextField extends StatelessWidget {
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
  final VoidCallback? onTap;
  final Color suffixIconColor;
  final double suffixIconSize;
  final Color preffixIconColor;
  final double preffixIconSize;
  final VoidCallback? suffixIconFunction;
  final Color themeColor;
  final Color backcolor;
  final String? Function(String?)? function;
  final String? Function(String?)? onChange;
  final String? Function(String?)? onComplete;
  final String? Function(String?)? onSaved;
  final String? Function()? onEditingComplete;
  double? textFieldheight;
  TextAlign? textAlign;
  final double width;
  final double height;

  CustomSearchTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.keyboardType,
    this.isPassword = false,
    this.enable = true,
    this.suffixIcon,
    this.suffixIconFunction,
    this.function,
    this.hasSuffix = false,
    this.hasPreffix = true,
    this.backcolor = Colors.transparent,
    this.themeColor = AppColors.primaryappcolor,
    this.suffixIconColor = AppColors.primarybackColor,
    this.suffixIconSize = 25,
    this.preffixIconColor = AppColors.searchIconColor,
    this.preffixIconSize = 30,
    this.onChange,
    this.onTap,
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
    this.width = 388,
    this.height = 60,
    required textcolor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      width: double.infinity,
      height: textFieldheight ?? 60,

      decoration: BoxDecoration(
   color: Color(0xffECECEC),
        borderRadius: BorderRadius.circular(25.r),
      ),
      
      padding: const EdgeInsets.all(16),
      child: TextFormField(
        enabled: enable,
        controller: controller,
        maxLines: maxLines,
        onTap: onTap,
        textAlign: textAlign ?? TextAlign.start,
        textInputAction: TextInputAction.next,
        cursorColor: themeColor,
        maxLength: maxLength,
        obscureText: isPassword ? obscureText.value : defaultObscureText.value,
        obscuringCharacter: "*",
        keyboardType: keyboardType,
        onFieldSubmitted: onComplete,
        onChanged: onChange,
        onSaved: onSaved,
        onEditingComplete: onEditingComplete,
        inputFormatters: [
          if (keyboardType == TextInputType.phone)
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
          else
            FilteringTextInputFormatter.allow(
              RegExp(
                r'[a-zA-ZÀ-ÿ0-9 @/:?\-_.]',
              ), // Allows accented letters like é
            ),

          if (keyboardType == TextInputType.phone)
            FilteringTextInputFormatter.deny(
              RegExp(r'[\.,\-_]'),
            ) // Deny special characters in phone numbers
          else
            FilteringTextInputFormatter.deny(RegExp(r'[#]')), // Restrict #
        ],
        style: TextStyle(color: AppColors.primaryappcolor, fontSize: 16.sp),
        validator: function,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: AppColors.primarybackColor.withOpacity(0.8),
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            fontFamily: 'Poppins',
          ),
          contentPadding:
              padding ?? EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          suffixIcon: hasSuffix
              ? InkWell(
                  child: isPassword
                      ? obscureText.value
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility)
                      : suffixIcon,
                )
              : const SizedBox(),
          prefixIcon: hasPreffix ? preffixIcon : null,
          isDense: true,

// Enabled border (default border when not focused)
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.kformborderColor.withOpacity(0.5), // Light border
      width: 1,
    ),
    borderRadius: BorderRadius.circular(10.r),
  ),

  // Focused border (when field is active)
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.kformborderColor,
      width: 1.5,
    ),
    borderRadius: BorderRadius.circular(10.r),
  ),

  // Error border (when there's an error)
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(10.r),
  ),

  // Focused error border (when focused and error exists)
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red,
      width: 1.5,
    ),
    borderRadius: BorderRadius.circular(10.r),
  ),

  // Optional: default border fallback
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.r),
    borderSide: BorderSide(
      color: AppColors.kformborderColor.withOpacity(0.5),
      width: 1,
    ),
  ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class SecondCustomTextField extends StatelessWidget {
  bool? isiconenable;
  final Widget? suffixIcon;
  final Widget? preffixIcon;
  final Color? suffixIconColor;
  final double? suffixIconSize;
  final Color? preffixIconColor;
  final double? preffixIconSize;
  final String? textcolor;
  final width;
  final height;
  String textval;

  TextEditingController textEditingController;
  SecondCustomTextField({
    super.key,
    required this.textval,
    this.suffixIcon,
    this.preffixIcon,
    this.height,
    this.width,
    this.textcolor,
    required this.textEditingController,
    this.isiconenable = false,
    this.suffixIconColor,
    this.suffixIconSize,
    this.preffixIconColor,
    this.preffixIconSize,
    required TextInputType keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.r)),
      width: width ?? 388.w,
      height: height ?? 158.h,
      child: TextFormField(
        maxLines: null,
        expands: true,
        minLines: null,

        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.transparent,
          labelText: textval,
          hintStyle: TextStyle(
            color: AppColors.kbluedark,
            fontSize: 17.sp,
            fontWeight: FontWeight.w400,
          ),
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
        style: TextStyle(
          color: AppColors.primaryappcolor,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
        controller: textEditingController,
      ),
    );
  }
}

///

class CustomTimeTextField extends StatelessWidget {
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
  final VoidCallback? onTap;
  final Color suffixIconColor;
  final double suffixIconSize;
  final Color preffixIconColor;
  final double preffixIconSize;
  final VoidCallback? suffixIconFunction;
  final Color themeColor;
  final Color backcolor;
  final double? height;
  final String? Function(String?)? function;
  final String? Function(String?)? onChange;
  final String? Function(String?)? onComplete;
  final String? Function(String?)? onSaved;
  final String? Function()? onEditingComplete;
  double? textFieldheight;
  TextAlign? textAlign;

  CustomTimeTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.keyboardType,
    this.isPassword = false,
    this.enable = true,
    this.height,
    this.suffixIcon,
    this.suffixIconFunction,
    this.function,
    this.hasSuffix = false,
    this.hasPreffix = true,
    this.backcolor = Colors.transparent,
    this.themeColor = AppColors.primaryappcolor,
    this.suffixIconColor = AppColors.primarybackColor,
    this.suffixIconSize = 25,
    this.preffixIconColor = AppColors.searchIconColor,
    this.preffixIconSize = 30,
    this.onChange,
    this.onTap,
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
    required textcolor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        // horizontal: .h,
        vertical: 10.w,
      ),
      width: double.infinity,
      height: height ?? 60.h,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(25.r),
      ),
      padding: const EdgeInsets.all(0),
      child: TextFormField(
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        // enabled: enable,
        controller: controller,
        maxLines: maxLines,
        onTap: onTap,
        textAlign: textAlign ?? TextAlign.start,
        textInputAction: TextInputAction.next,
        cursorColor: themeColor,

        // cursorWidth: 2.0,
        maxLength: maxLength,
        // cursorHeight: kHeight(.024),
        obscureText: isPassword ? obscureText.value : defaultObscureText.value,
        obscuringCharacter: "*",
        keyboardType: keyboardType,
        onFieldSubmitted: onComplete,
        onChanged: onChange,
        onSaved: onSaved,
        onEditingComplete: onEditingComplete,
        inputFormatters: [
          if (keyboardType == TextInputType.phone)
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
          else
            FilteringTextInputFormatter.allow(
              RegExp(
                r'[a-zA-ZÀ-ÿ0-9 @/:?\-_.]',
              ), // Allows accented letters like é
            ),

          if (keyboardType == TextInputType.phone)
            FilteringTextInputFormatter.deny(
              RegExp(r'[\.,\-_]'),
            ) // Deny special characters in phone numbers
          else
            FilteringTextInputFormatter.deny(RegExp(r'[#]')), // Restrict #
        ],
        style: TextStyle(color: AppColors.primaryappcolor, fontSize: 16.sp),
        validator: function,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: AppColors.primarybackColor.withOpacity(0.8),
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            fontFamily: 'Poppins',
          ),
          contentPadding:
              padding ??
              EdgeInsets.symmetric(
                horizontal: 10,
                vertical: textFieldheight ?? 18,
              ),
          fillColor: AppColors.textfieldcolor,
          filled: true,

          // prefixIcon: Icon(Icons.search,size: preffixIconSize,color: preffixIconColor,),
          // suffixIcon: Icon(Icons.voice_over_off_outlined,size: suffixIconSize,color: suffixIconColor,),
          suffixIcon: hasSuffix
              ? InkWell(
                  // onTap: isPassword
                  //     ? () {
                  //         obscureText.value = !obscureText.value;
                  //       }
                  //     : suffixIconFunction,
                  child: isPassword
                      ? obscureText.value
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility)
                      : suffixIcon,
                )
              : const SizedBox(),
          prefixIcon: hasPreffix ? preffixIcon : null,
          isDense: true,

          // disabledBorder: OutlineInputBorder(
          //   borderSide: BorderSide(
          //     // color: AppColors.greyColor.withOpacity(.6),
          //     width: .5,
          //     strokeAlign: BorderSide.strokeAlignInside,
          //   ),
          //   borderRadius: BorderRadius.circular(
          //     10.r,
          //   ),
          // ),
          // enabledBorder: OutlineInputBorder(
          //   borderSide: BorderSide(
          //     // color: AppColors.black1A.withOpacity(.6),
          //     color: Colors.transparent,
          //     width: .0,
          //     strokeAlign: BorderSide.strokeAlignInside,
          //   ),
          //   borderRadius: BorderRadius.circular(
          //     10.r,
          //   ),
          // ),
          // focusedBorder: OutlineInputBorder(
          //   borderSide: const BorderSide(
          //     // color: AppColors.primaryYellow,
          //     width: 1,
          //     strokeAlign: BorderSide.strokeAlignInside,
          //   ),
          //   borderRadius: BorderRadius.circular(
          //     10.r,
          //   ),
          // ),
          // border: UnderlineInputBorder(
          //   borderSide: BorderSide(
          //     // color: AppColors.primaryYellow,
          //     width: .0,
          //     strokeAlign: BorderSide.strokeAlignInside,
          //   ),
          //   borderRadius: BorderRadius.circular(
          //     10.r,
          //   ),
          // ),
          // focusedErrorBorder: UnderlineInputBorder(
          //   borderSide: const BorderSide(
          //     color: Colors.blue,
          //     width: .5,
          //     strokeAlign: BorderSide.strokeAlignInside,
          //   ),
          //   borderRadius: BorderRadius.circular(
          //     10.r,
          //   ),
          //   // gapPadding: 20,
          // ),
          // errorBorder: OutlineInputBorder(
          //   borderSide: BorderSide(
          //     // color: AppColors.primaryYellow.withOpacity(.6),
          //     color: Colors.transparent,
          //     width: .5,
          //     strokeAlign: BorderSide.strokeAlignInside,
          //   ),
          //   borderRadius: BorderRadius.circular(
          //     10.r,
          //   ),
          // ),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10.r),
          ),

          // focusedBorder:
          //     UnderlineInputBorder(borderRadius: BorderRadius.circular(20.r)),
          // enabledBorder:
          //     UnderlineInputBorder(borderRadius: BorderRadius.circular(20.r)),
        ),
      ),
    );
  }
}
