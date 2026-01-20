import 'package:flutter/material.dart';
import 'package:taffi/core/constants/app_constants.dart';
import 'package:taffi/core/theme/app_colors.dart';

class GovernorateDropdown extends StatelessWidget {
  const GovernorateDropdown({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  final String initialValue;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      dropdownMenuEntries: AppConstants.iraqGovernorates
          .map((e) {
            return DropdownMenuEntry(value: e, label: e);
          })
          .toList(),
      trailingIcon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: AppColors.primary,
      ),
      selectedTrailingIcon: const Icon(
        Icons.keyboard_arrow_up_rounded,
        color: AppColors.primary,
      ),
      initialSelection: initialValue,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        constraints: BoxConstraints.tight(
          const Size.fromHeight(54),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1.8,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1.4,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1.4,
          ),
        ),
      ),
      menuHeight: 200,
      textStyle: const TextStyle(
        fontSize: 16,
        color: AppColors.textPrimary,
      ),
      menuStyle: const MenuStyle(
        backgroundColor: WidgetStatePropertyAll(
          AppColors.background,
        ),
        alignment: Alignment.topRight,
      ),
      onSelected: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
    );
  }
}
