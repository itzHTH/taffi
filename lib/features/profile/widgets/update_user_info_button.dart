import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taffi/core/enums/status_enum.dart';
import 'package:taffi/core/utils/snackbar_helper.dart';
import 'package:taffi/features/auth/providers/user_provider.dart';

class UpdateUserInfoButton extends StatelessWidget {
  const UpdateUserInfoButton({
    super.key,
    required this.formKey,
    required this.fullNameController,
    required this.phoneController,
    required this.ageController,
    required this.selectedGovernorate,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController fullNameController;
  final TextEditingController phoneController;
  final TextEditingController ageController;
  final String selectedGovernorate;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          bool isLoading = userProvider.updateUserStatus == Status.loading;
          return ElevatedButton(
            onPressed: isLoading
                ? null
                : () async {
                    if (formKey.currentState!.validate()) {
                      await userProvider.updateUserInfo(
                        fullname: fullNameController.text,
                        phone: phoneController.text,
                        age: ageController.text,
                        governorate: selectedGovernorate,
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
                ? const CircularProgressIndicator()
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
