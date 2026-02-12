import 'package:jewellery/core/widgets/custom_text.dart';

import '../../core/theme/app_imports.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonStyle? style;
  final Color? backgroundColor;
  final Color textColor;
  final Color iconColor;
  final double borderRadius;
  final double verticalPadding;
  final double horizontalPadding;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool isLoading;
  final TextAlign? textAlign;
  final double? fontSize;
  final FontWeight? fontWidth;
  final double? height;
  final bool underline;
  final Color? underlineColor;

  // 👇 New Properties
  final Color? borderColor;
  final double borderWidth;
  final double? showShadow;

  const CustomElevatedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.style,
    this.height,
    this.backgroundColor,
    this.textColor = CustomColor.whitePrimary,
    this.iconColor = CustomColor.whitePrimary,
    this.borderRadius = 8,
    this.verticalPadding = 10,
    this.horizontalPadding = 22,
    this.leadingIcon,
    this.trailingIcon,
    this.isLoading = false,
    this.textAlign,
    this.fontSize,
    this.fontWidth,
    this.borderColor,
    this.borderWidth = 1,
    this.showShadow,
    this.underline = false,
    this.underlineColor, // ← new property
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height ?? 34.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style:
            style ??
            ButtonStyle(
              backgroundColor: MaterialStateProperty.all(backgroundColor ?? CustomColor.redPrimary),
              foregroundColor: MaterialStateProperty.all(textColor),
              elevation: MaterialStateProperty.all(showShadow ?? 0.0),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  side: BorderSide(color: borderColor ?? Colors.transparent, width: borderWidth),
                ),
              ),
              padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
              ),
            ),
        child: isLoading
            ? SizedBox(
                height: 20.h,
                width: 20.w,
                child: CircularProgressIndicator(color: textColor, strokeWidth: 2),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (leadingIcon != null) ...[
                    IconTheme(
                      data: IconThemeData(color: iconColor),
                      child: leadingIcon!,
                    ),
                    SizedBox(width: 8.w),
                  ],

                  Flexible(
                    child: CustomText(
                      text,
                      color: textColor,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: fontWidth ?? FontWeight.w500,
                      fontSize: fontSize ?? 12.sp,
                      textAlign: textAlign ?? TextAlign.center,
                      softWrap: false,
                      decoration: underline ? TextDecoration.underline : TextDecoration.none,
                    ),
                  ),

                  if (trailingIcon != null) ...[
                    SizedBox(width: 8.w),
                    IconTheme(
                      data: IconThemeData(color: iconColor),
                      child: trailingIcon!,
                    ),
                  ],
                ],
              ),
      ),
    );
  }
}
