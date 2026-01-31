import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taffi/core/enums/status_enum.dart';
import 'package:taffi/core/utils/snackbar_helper.dart';
import 'package:taffi/features/auth/providers/user_provider.dart';

class UpdateUserInfoButton extends StatefulWidget {
  const UpdateUserInfoButton({
    super.key,
    required this.formKey,
    required this.fullNameController,
    required this.phoneController,
    required this.ageController,
    required this.selectedGovernorate,
    this.isEnabled = true,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController fullNameController;
  final TextEditingController phoneController;
  final TextEditingController ageController;
  final String selectedGovernorate;
  final bool isEnabled;

  @override
  State<UpdateUserInfoButton> createState() => _UpdateUserInfoButtonState();
}

class _UpdateUserInfoButtonState extends State<UpdateUserInfoButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          bool isLoading = userProvider.updateUserStatus == Status.loading;
          return ElevatedButton(
            onPressed: (isLoading || !widget.isEnabled)
                ? null
                : () async {
                    if (widget.formKey.currentState!.validate()) {
                      await userProvider.updateUserInfo(
                        fullname: widget.fullNameController.text,
                        phone: widget.phoneController.text,
                        age: widget.ageController.text,
                        governorate: widget.selectedGovernorate,
                      );
                      if (!context.mounted) return;
                      if (userProvider.updateUserStatus == Status.success) {
                        userProvider.getUserInfo();
                        if (context.mounted) {
                          SnackBarHelper.showSuccess(context, "تم تحديث المعلومات بنجاح");
                          Navigator.pop(context);
                        }
                      } else {
                        SnackBarHelper.showError(context, userProvider.errorMessage);
                      }
                    }
                  },
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Text(
                    "تحديث المعلومات",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
          );
        },
      ),
    );
  }
}
