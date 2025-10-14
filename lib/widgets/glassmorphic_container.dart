import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart' as glass;

class GlassmorphicContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? borderColor;
  final double? borderWidth;
  final double? blur;
  final double? opacity;
  final Color? gradientStart;
  final Color? gradientEnd;
  final BoxShadow? shadow;

  const GlassmorphicContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.borderRadius,
    this.padding,
    this.margin,
    this.borderColor,
    this.borderWidth,
    this.blur,
    this.opacity,
    this.gradientStart,
    this.gradientEnd,
    this.shadow,
  });

  @override
  Widget build(BuildContext context) {
    return glass.GlassmorphicContainer(
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      borderRadius: 20.0, // مقدار پیش‌فرض به صورت double
      padding: padding ?? const EdgeInsets.all(16),
      margin: margin ?? EdgeInsets.zero,
      border: borderWidth ?? 1,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          gradientStart ?? const Color(0xFFffffff).withOpacity(opacity ?? 0.1),
          gradientEnd ?? const Color(0xFFFFFFFF).withOpacity(opacity ?? 0.05),
        ],
        stops: const [0.1, 1],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          borderColor ?? Colors.white.withOpacity(0.5),
          borderColor ?? Colors.white.withOpacity(0.5),
        ],
      ),
      blur: blur ?? 15,
      child: child,
    );
  }
}
