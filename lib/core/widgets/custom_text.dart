import '../theme/app_fonts.dart';
import '../theme/app_imports.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final double? letterSpacing;
  final double? lineHeight;
  final bool? softWrap;
  final FontBuilder? font;
  final Gradient? gradient;

  const CustomText(
    this.text, {
    super.key,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.decoration,
    this.letterSpacing,
    this.lineHeight,
    this.softWrap,
    this.font,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      softWrap: softWrap,
      style: AppTextStyles.style(
        size: fontSize,
        color: gradient == null ? color : Colors.white,
        fontWeight: fontWeight ?? FontWeight.w400,
        font: font,
        overflow: overflow,
      ).copyWith(decoration: decoration, letterSpacing: letterSpacing, height: lineHeight),
    );

    // ✅ If gradient is provided, wrap with ShaderMask
    if (gradient != null) {
      return ShaderMask(
        shaderCallback: (bounds) =>
            gradient!.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
        blendMode: BlendMode.srcIn,
        child: textWidget,
      );
    }

    return textWidget;
  }
}
