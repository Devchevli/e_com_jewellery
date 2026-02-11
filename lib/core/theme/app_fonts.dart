import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jewellery/core/theme/app_imports.dart';

typedef FontBuilder =
    TextStyle Function({
      TextStyle? textStyle,
      FontWeight? fontWeight,
      double? fontSize,
      Color? color,
    });

class AppTextStyles {
  static const Color defaultColor = CustomColor.whitePrimary;
  static const double defaultFontSize = 14;

  static FontBuilder defaultFont = GoogleFonts.manrope;

  static TextStyle style({
    double? size,
    FontWeight fontWeight = FontWeight.w400,
    Color? color,
    FontBuilder? font, // <- override font anytime
    TextOverflow? overflow,
  }) {
    final builder = font ?? defaultFont;

    return builder(
      fontSize: (size ?? defaultFontSize).sp,
      fontWeight: fontWeight,
      color: color ?? defaultColor,
      textStyle: TextStyle(overflow: overflow ?? TextOverflow.ellipsis),
    );
  }

  // Shortcuts
  static TextStyle light({double? size, Color? color, FontBuilder? font}) =>
      style(size: size, fontWeight: FontWeight.w300, color: color, font: font);

  static TextStyle regular({double? size, Color? color, FontBuilder? font}) =>
      style(size: size, fontWeight: FontWeight.w400, color: color, font: font);

  static TextStyle medium({double? size, Color? color, FontBuilder? font}) =>
      style(size: size, fontWeight: FontWeight.w500, color: color, font: font);

  static TextStyle semiBold({double? size, Color? color, FontBuilder? font}) =>
      style(size: size, fontWeight: FontWeight.w600, color: color, font: font);

  static TextStyle bold({double? size, Color? color, FontBuilder? font}) =>
      style(size: size, fontWeight: FontWeight.w700, color: color, font: font);
}
