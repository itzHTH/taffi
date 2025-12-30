import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taffi/core/theme/app_colors.dart';

class CustomTextFormFiled extends StatefulWidget {
  const CustomTextFormFiled({
    super.key,
    required this.hint,
    this.prefixIcon,
    this.isPassword = false,
    required this.validator,
    this.textEditingController,
    this.verticalContentPadding = 0,
    this.hidePasswordIcon = true,
    this.isPasswordVisible,
    this.onPasswordVisibilityChanged,
    this.keyboardType,
    this.textInputAction,
    this.onFieldSubmitted,
    this.scrollPadding,
    this.borderRadius,
  });

  final String hint;
  final String? prefixIcon;
  final bool isPassword;
  final bool hidePasswordIcon;
  final double verticalContentPadding;
  final TextEditingController? textEditingController;
  final bool? isPasswordVisible;
  final ValueChanged<bool>? onPasswordVisibilityChanged;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function(String value)? onFieldSubmitted;
  final EdgeInsets? scrollPadding;
  final String? Function(String? value) validator;
  final double? borderRadius;

  @override
  State<CustomTextFormFiled> createState() => _CustomTextFormFiledState();
}

class _CustomTextFormFiledState extends State<CustomTextFormFiled> {
  bool _isHide = true;

  bool get _isPasswordHidden {
    return widget.isPasswordVisible ?? _isHide;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      autocorrect: widget.isPassword,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      validator: widget.validator,
      scrollPadding: widget.scrollPadding ?? EdgeInsets.all(20),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: widget.verticalContentPadding,
          horizontal: 10,
        ),
        prefixIcon: widget.prefixIcon != null
            ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.asset(
                  widget.prefixIcon!,
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                ),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 20),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.4),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 20),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 20),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.4),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 20),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        hintText: widget.hint,
        hintStyle: TextStyle(
          fontSize: 16,
          color: AppColors.primary.withValues(alpha: 0.73),
        ),
        suffixIcon: widget.isPassword && !widget.hidePasswordIcon
            ? IconButton(
                onPressed: () {
                  final newValue = !_isPasswordHidden;
                  if (widget.onPasswordVisibilityChanged != null) {
                    widget.onPasswordVisibilityChanged!(newValue);
                  } else {
                    setState(() {
                      _isHide = newValue;
                    });
                  }
                },
                icon: Icon(
                  _isPasswordHidden
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
                color: AppColors.primary,
              )
            : null,
      ),
      obscureText: widget.isPassword ? _isPasswordHidden : false,

      cursorColor: AppColors.primary,
    );
  }
}
