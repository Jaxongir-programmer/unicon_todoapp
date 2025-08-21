import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/core/util/extensions/extensions.dart';
import 'package:todoapp/features/common/presentation/widgets/scale_animation_widget.dart';

import '../../../../core/config/app_colors.dart';

class CustomButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String text;
  final Color? color;
  final Color? textColor;
  final TextStyle? textStyle;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final GestureTapCallback onTap;
  final BoxBorder? border;
  final double borderRadius;
  final Widget? child;
  final Color disabledColor;
  final Color disabledTextColor;
  final bool isDisabled;
  final bool isLoading;
  final double? scaleValue;
  final List<BoxShadow>? shadow;
  final Gradient? gradient;
  final Widget? prefix;
  final Widget? suffix;
  final bool isExpanded;

  const CustomButton({
    required this.onTap,
    this.text = '',
    this.color = AppColors.primaryButtonColor,
    this.textColor = AppColors.white,
    this.borderRadius = 8,
    this.disabledColor = AppColors.disabledButton,
    this.disabledTextColor = AppColors.disabledTextColor,
    this.isDisabled = false,
    this.isLoading = false,
    this.isExpanded = false,
    this.width,
    this.height,
    this.margin,
    this.padding ,
    this.textStyle,
    this.border,
    this.child,
    this.scaleValue,
    this.shadow,
    this.gradient,
    this.prefix,
    this.suffix,
    super.key,
  });

  factory CustomButton.border({
    required GestureTapCallback onTap,
    String text = "",
    Color textColor = AppColors.white,
    Color disabledColor = Colors.grey,
    bool isDisabled = false,
    bool isLoading = false,
    Color? color,
    double? borderRadius,
    double? width,
    double? height,
    EdgeInsets? margin,
    EdgeInsets? padding,
    TextStyle? textStyle,
    BoxBorder? border,
    double? scaleValue,
    List<BoxShadow>? shadow,
    Gradient? gradient,
    Widget? prefix,
    Widget? suffix,
    Widget? child,
  }) =>
      CustomButton(
        onTap: onTap,
        height: height,
        borderRadius: 8,
        padding: EdgeInsets.symmetric(horizontal: 16),
        textStyle: textStyle,
        gradient: AppColors.buttonGradient,
        text: text,
        color: color ?? AppColors.primaryButtonColor,
        textColor: textColor,
        disabledColor: disabledColor,
        isDisabled: isDisabled,
        isLoading: isLoading,
        width: width,
        margin: margin,
        scaleValue: scaleValue,
        prefix: prefix,
        suffix: suffix,
        child: child,
      );

  factory CustomButton.light({
    required GestureTapCallback onTap,
    String text = "",
    Color textColor = AppColors.primaryColor,
    Color disabledColor = Colors.grey,
    bool isDisabled = false,
    bool isLoading = false,
    bool isExpanded = false,
    Color? color = AppColors.buttonPrimaryLight,
    double borderRadius = 8,
    double? width,
    double? height,
    EdgeInsets? margin,
    EdgeInsets? padding,
    TextStyle? textStyle,
    BoxBorder? border,
    double? scaleValue,
    List<BoxShadow>? shadow,
    Widget? prefix,
    Widget? suffix,
    Widget? child,
  }) =>
      CustomButton(
        onTap: onTap,
        height: height,
        border: border,
        borderRadius: borderRadius,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 16),
        textStyle: textStyle,
        text: text,
        color: color,
        textColor: textColor,
        disabledColor: disabledColor,
        isDisabled: isDisabled,
        isLoading: isLoading,
        width: width,
        margin: margin,
        scaleValue: scaleValue,
        prefix: prefix,
        suffix: suffix,
        isExpanded: isExpanded,
        child: child,
      );

  factory CustomButton.outline({
    required GestureTapCallback onTap,
    String text = '',
    Color textColor = AppColors.primaryColor,
    Color disabledColor = Colors.grey,
    bool isDisabled = false,
    bool isLoading = false,
    Color? color,
    double? borderRadius,
    double? width,
    double? height,
    EdgeInsets? margin,
    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 16),
    TextStyle? textStyle,
    BoxBorder? border,
    double? scaleValue,
    List<BoxShadow>? shadow,
    Gradient? gradient,
    Widget? prefix,
    Widget? child,
    Widget? suffix,
  }) =>
      CustomButton(
        onTap: onTap,
        height: height,
        color: Colors.transparent,
        textColor: textColor,
        padding: padding,
        borderRadius: borderRadius ?? 8,
        border: Border.all(
          color: AppColors.primaryColor,
        ),
        textStyle: textStyle,
        gradient: AppColors.buttonGradient,
        text: text,
        disabledColor: disabledColor,
        isDisabled: isDisabled,
        isLoading: isLoading,
        width: width,
        margin: margin,
        scaleValue: scaleValue,
        prefix: prefix,
        suffix: suffix,
        child: child,
      );

  factory CustomButton.transparent({
    required GestureTapCallback onTap,
    String text = '',
    Color textColor = AppColors.primaryColor,
    Color disabledColor = Colors.grey,
    bool isDisabled = false,
    bool isLoading = false,
    Color? color,
    double? borderRadius,
    double? width,
    double? height,
    EdgeInsets? margin,
    EdgeInsets? padding,
    TextStyle? textStyle,
    BoxBorder? border,
    double? scaleValue,
    List<BoxShadow>? shadow,
    Gradient? gradient,
    Widget? prefix,
    Widget? child,
    Widget? suffix,
  }) =>
      CustomButton(
        onTap: onTap,
        height: height,
        color: color ?? Colors.transparent,
        textColor: textColor,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 16),
        borderRadius: borderRadius ?? 8,
        textStyle: textStyle,
        text: text,
        disabledColor: Colors.transparent,
        disabledTextColor: AppColors.primaryColor,
        isDisabled: isDisabled,
        isLoading: isLoading,
        width: width,
        margin: margin,
        scaleValue: scaleValue,
        prefix: prefix,
        suffix: suffix,
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    final button = ScaleAnimationWidget(
      scaleValue: scaleValue ?? 1,
      onTap: () {
        if (!(isLoading || isDisabled)) {
          onTap();
        }
      },
      isDisabled: isDisabled,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: width,
        height: height ?? 48,
        margin: margin,
        padding: padding ?? EdgeInsets.zero,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isDisabled ? disabledColor : color,
          borderRadius: BorderRadius.circular(borderRadius),
          border: border,
          boxShadow: shadow,
          gradient: gradient,
        ),
        child: isLoading
            ? const Center(child: CupertinoActivityIndicator(color: Colors.white))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 4,
                children: [
                  if (prefix != null) prefix!,
                  child ??
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: (textStyle ?? context.textTheme.headlineMedium)!
                            .copyWith(color: isDisabled ? disabledTextColor : textColor),
                        child: Text(
                          text,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                  if (suffix != null) suffix!,
                ],
              ),
      ),
    );
    if (isExpanded) {
      return Expanded(
        child: button,
      );
    } else {
      return button;
    }
  }
}
