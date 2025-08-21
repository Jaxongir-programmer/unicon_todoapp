import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todoapp/core/util/extensions/extensions.dart';

import '../../../../core/config/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final EdgeInsets contentPadding;
  final Widget? prefix;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffix;
  final double prefixMaxWidth;
  final double suffixMaxWidth;
  final TextStyle? style;
  final TextStyle? errorStyle;
  final TextStyle? hintStyle;
  final String? hintText;
  final String? labelText;
  final bool hasError;
  final bool isObscure;
  final String prefixText;
  final InputDecoration? inputDecoration;
  final TextInputType? keyboardType;
  final String title;
  final String errorText;
  final double? height;
  final Color fillColor;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool autoFocus;
  final FocusNode? focusNode;
  final TextAlignVertical? textAlignVertical;
  final bool expands;
  final bool? enabled;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final bool showCount;
  final TextInputAction? textInputAction;
  final TextStyle? titleStyle;
  final TextCapitalization textCapitalization;
  final Function(String)? onFieldSubmitted;

  CustomTextField({
    this.autoFocus = false,
    this.showCount = false,
    this.focusNode,
    this.textInputAction,
    this.maxLengthEnforcement,
    required this.controller,
    required this.onChanged,
    this.prefix,
    this.title = '',
    this.errorText = '',
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16),
    this.inputFormatters,
    this.suffix,
    this.prefixMaxWidth = 40,
    this.suffixMaxWidth = 40,
    this.errorStyle,
    this.hintStyle,
    this.hintText,
    this.style,
    this.labelText,
    this.isObscure = false,
    this.fillColor = Colors.transparent,
    this.hasError = false,
    this.prefixText = '',
    this.inputDecoration,
    this.keyboardType,
    this.height,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLength,
    this.titleStyle,
    this.textAlignVertical,
    this.expands = false,
    this.enabled = true,
    this.textCapitalization = TextCapitalization.none,
    this.onFieldSubmitted,
    super.key,
  });

  final ValueNotifier<bool> _obscureText = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        if (title.isNotEmpty) Text(title, style: titleStyle ?? Theme.of(context).textTheme.labelSmall),
        ValueListenableBuilder(
          valueListenable: _obscureText,
          builder: (context, value, _) => TextFormField(
            onFieldSubmitted: onFieldSubmitted,
            textCapitalization: textCapitalization,
            enabled: enabled,
            expands: expands,
            maxLengthEnforcement: maxLengthEnforcement,
            textAlignVertical: textAlignVertical,
            focusNode: focusNode,
            autofocus: autoFocus,
            controller: controller,
            onChanged: onChanged,
            textInputAction: textInputAction,
            style: style ?? context.textTheme.bodyLarge,
            inputFormatters: inputFormatters,
            obscureText: !value && isObscure,
            obscuringCharacter: '●',
            keyboardType: keyboardType,
            maxLength: (expands && !isObscure) ? null : maxLength,
            maxLines: (expands && !isObscure) ? null : maxLines,
            minLines: (expands && !isObscure) ? null : minLines,
            decoration: inputDecoration ??
                InputDecoration(
                  label: labelText != null
                      ? Text(
                          labelText!,
                          style: hintStyle ??
                              context.textTheme.bodyLarge!.copyWith(
                                color: AppColors.hintColor,
                              ),
                        )
                      : null,
                  hintText: hintText,
                  hintStyle: hintStyle ??
                      context.textTheme.bodyLarge!.copyWith(
                        color: AppColors.hintColor,
                      ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  contentPadding: contentPadding,
                  suffixIconConstraints: BoxConstraints(maxWidth: 48),
                  fillColor: fillColor,
                  filled: true,
                  prefixIconConstraints: BoxConstraints(
                    maxWidth: prefixMaxWidth,
                  ),
                  prefixIcon: prefix,
                  counterText: '',
                  constraints: BoxConstraints(minHeight: height ?? 48, maxHeight: height ?? 48),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.borderColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.borderColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
          ),
        ),
        if (hasError) ...[
          Text(
            "* $errorText",
            softWrap: false,
            textAlign: TextAlign.start,
            maxLines: 2,
            style: errorStyle ??
                context.textTheme.labelMedium!.copyWith(color: AppColors.error)
          ),
        ],
      ],
    );
  }
}
