import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:taxi_driver/core/constants/app_colors.dart';
import 'package:taxi_driver/core/constants/app_fonts.dart';

class CText extends StatelessWidget {
  final String text;
  final TextAlign alignText;
  int? maxLines;
  final Color? color;
  final double fontSize;
  final bool softWrap;
  final FontWeight fontWeight;
  final double? minFontSize;
  final bool ellipsisText;
  final double? lineHeight;
  final String? fontFamily;
  final TextDecoration? textDecoration;
  final TextOverflow? overflow;

  final TextStyle? style;
  
  CText({
    super.key,
    required this.text,
    this.color,
    this.style,
    required this.fontSize,
    this.alignText = TextAlign.start,
    this.maxLines,
    this.fontWeight = FontWeight.normal,
    this.ellipsisText = true,
    this.softWrap = true,
    this.minFontSize,
    this.textDecoration,
    this.fontFamily,
    this.lineHeight,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: alignText,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.ellipsis,
      style: style ?? TextStyle(
        color: color ?? AppColors.headingcolor,
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
        fontFamily: fontFamily ?? AppFonts.fontFamily,
        height: lineHeight,
        decoration: textDecoration,
      ),
    );
  }
}