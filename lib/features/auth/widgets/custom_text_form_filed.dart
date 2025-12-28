import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taffi/core/theme/app_colors.dart';

class CustomTextFormFiled extends StatefulWidget {
  const CustomTextFormFiled({
    super.key,
    required this.hint,
    required this.prefixIcon,
    this.isPassword = false,
    required this.validator,
    this.textEditingController,
  });

  final String hint;
  final String prefixIcon;
  final bool isPassword;
  final TextEditingController? textEditingController;

  final String? Function(String? value) validator;

  @override
  State<CustomTextFormFiled> createState() => _CustomTextFormFiledState();
}

class _CustomTextFormFiledState extends State<CustomTextFormFiled> {
  bool _isHide = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      autocorrect: widget.isPassword,

      validator: widget.validator,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 20),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset(
            widget.prefixIcon,
            width: 20,
            height: 20,
            fit: BoxFit.contain,
          ),
        ),
        hintText: widget.hint,
        hintStyle: TextStyle(
          fontSize: 16,
          color: AppColors.primary.withValues(alpha: 0.73),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _isHide = !_isHide;
                  });
                },
                icon: Icon(
                  _isHide
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
                color: AppColors.primary,
              )
            : null,
      ),
      obscureText: widget.isPassword ? _isHide : false,

      cursorColor: AppColors.primary,
    );
  }
}
