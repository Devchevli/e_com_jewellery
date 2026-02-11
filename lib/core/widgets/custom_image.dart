import 'package:jewellery/core/theme/app_imports.dart';

class CustomImage extends StatelessWidget {
  final String imageUrl;
  final String? assetPath;
  final Widget? placeholder;
  final Widget? errorWidget;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius borderRadius;
  final Color? backgroundColor;
  final EdgeInsetsGeometry padding;
  final List<BoxShadow>? boxShadow;
  final bool showLoadingIndicator;
  final Duration fadeInDuration;
  final bool isCircle;
  final bool isResponsive;
  final Color? color;
  final Border? border;
  final double borderWidth;
  final Color borderColor;
  final bool showBorder;

  const CustomImage.network({
    super.key,
    required this.imageUrl,
    this.placeholder,
    this.errorWidget,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = BorderRadius.zero,
    this.backgroundColor,
    this.padding = EdgeInsets.zero,
    this.boxShadow,
    this.showLoadingIndicator = true,
    this.fadeInDuration = const Duration(milliseconds: 300),
    this.isCircle = false,
    this.isResponsive = true,
    this.color,
    this.border,
    this.borderWidth = 1.0,
    this.borderColor = CustomColor.greyMedium, // Changed from AppColors.border
    this.showBorder = false,
  }) : assetPath = null;

  const CustomImage.asset({
    super.key,
    required this.assetPath,
    this.placeholder,
    this.errorWidget,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = BorderRadius.zero,
    this.backgroundColor,
    this.padding = EdgeInsets.zero,
    this.boxShadow,
    this.showLoadingIndicator = false,
    this.fadeInDuration = const Duration(milliseconds: 300),
    this.isCircle = false,
    this.isResponsive = true,
    this.color,
    this.border,
    this.borderWidth = 1.0,
    this.borderColor = CustomColor.greyMedium, // Changed from AppColors.border
    this.showBorder = false,
  }) : imageUrl = '';

  @override
  Widget build(BuildContext context) {
    final responsiveWidth = width != null && isResponsive ? width!.w : width;
    final responsiveHeight = height != null && isResponsive ? height!.h : height;
    final responsivePadding = padding;
    final responsiveBorderWidth = isResponsive ? borderWidth.w : borderWidth;

    return Container(
      width: width == null ? null : responsiveWidth,
      height: height == null ? null : responsiveHeight,

      padding: responsivePadding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: isCircle ? null : borderRadius.r,
        boxShadow: boxShadow,
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        border: _getBorder(responsiveBorderWidth),
      ),
      child: ClipRRect(
        borderRadius: isCircle ? BorderRadius.circular(100.r) : borderRadius.r,
        clipBehavior: Clip.antiAlias,
        child: _buildImageContent(),
      ),
    );
  }

  Border? _getBorder(double width) {
    if (border != null) return border;
    if (!showBorder) return null;
    return Border.all(color: borderColor, width: width);
  }

  Widget _buildImageContent() {
    if (assetPath != null) {
      return Image.asset(
        assetPath!,
        width: width,
        height: height,
        fit: fit,
        color: color,
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded) {
            return child;
          }
          return AnimatedOpacity(
            opacity: frame == null ? 0 : 1,
            duration: fadeInDuration,
            child: child,
          );
        },
        errorBuilder: (context, error, stackTrace) => errorWidget ?? _defaultErrorWidget(),
      );
    } else {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        color: color,
        placeholder: (context, url) =>
            placeholder ?? (showLoadingIndicator ? _loadingWidget() : const SizedBox()),
        errorWidget: (context, url, error) => errorWidget ?? _defaultErrorWidget(),
        fadeInDuration: fadeInDuration,
        fadeInCurve: Curves.easeIn,
        memCacheHeight: isResponsive ? (height?.toInt() ?? 300) : null,
        memCacheWidth: isResponsive ? (width?.toInt() ?? 300) : null,
      );
    }
  }

  Widget _loadingWidget() {
    return Center(
      child: SizedBox(
        width: isResponsive ? 24.w : 24,
        height: isResponsive ? 24.h : 24,
        child: CircularProgressIndicator(
          strokeWidth: isResponsive ? 2.w : 2,
          valueColor: AlwaysStoppedAnimation(
            CustomColor.redPrimary,
          ), // Changed from AppColors.primaryBlue
        ),
      ),
    );
  }

  Widget _defaultErrorWidget() {
    return Container(
      color: CustomColor.greyExtraLight, // Changed from AppColors.fieldBackground
      child: Center(
        child: Icon(
          Icons.broken_image,
          size: isResponsive ? 40.sp : 40,
          color: CustomColor.greyDark, // Changed from AppColors.placeholder
        ),
      ),
    );
  }
}
