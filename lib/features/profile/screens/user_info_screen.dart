import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taffi/core/constants/app_constants.dart';
import 'package:taffi/core/theme/app_colors.dart';
import 'package:taffi/core/utils/validators.dart';
import 'package:taffi/core/widgets/custom_text_form_field.dart';
import 'package:taffi/features/auth/providers/user_provider.dart';
import 'package:taffi/features/profile/widgets/disabled_text_field.dart';
import 'package:taffi/features/profile/widgets/field_label.dart';
import 'package:taffi/features/profile/widgets/governorate_dropdown.dart';
import 'package:taffi/features/profile/widgets/update_user_info_button.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  String _selectedGovernorate = AppConstants.iraqGovernorates.first;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = context.read<UserProvider>();
      _fullNameController.text = userProvider.user!.fullName ?? "";
      _userNameController.text = userProvider.user!.userName ?? "";
      _emailController.text = userProvider.user!.email ?? "";
      _phoneController.text = userProvider.user!.phoneNumber ?? "";
      _ageController.text = userProvider.user!.age.toString();
      _selectedGovernorate = userProvider.user!.governorate ?? "بغداد";
    });
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded, color: AppColors.primary),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text("المعلومات الشخصيه", style: Theme.of(context).textTheme.titleLarge),
        ),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 24),
                    Hero(
                      tag: 'profile_image',
                      child: Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[200],
                          image: const DecorationImage(
                            image: AssetImage('assets/images/user.png'),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.2),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const FieldLabel(label: "الاسم الكامل"),
                    const SizedBox(height: 8),
                    CustomTextFormField(
                      hint: "ادخل اسمك الكامل",
                      validator: (value) => Validators.fullName(value),
                      textEditingController: _fullNameController,
                      textInputAction: TextInputAction.next,
                      borderRadius: 12,
                      verticalContentPadding: 16,
                    ),
                    const SizedBox(height: 20),
                    const FieldLabel(label: "اسم المستخدم"),
                    const SizedBox(height: 8),
                    DisabledTextField(controller: _userNameController),
                    const SizedBox(height: 20),
                    const FieldLabel(label: "البريد الإلكتروني"),
                    const SizedBox(height: 8),
                    DisabledTextField(controller: _emailController),
                    const SizedBox(height: 20),
                    const FieldLabel(label: "رقم الهاتف"),
                    const SizedBox(height: 8),
                    CustomTextFormField(
                      hint: "ادخل رقم الهاتف",
                      validator: (value) => Validators.phone(value),
                      textEditingController: _phoneController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      borderRadius: 12,
                      verticalContentPadding: 16,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FieldLabel(label: "المحافظة"),
                              const SizedBox(height: 8),
                              GovernorateDropdown(
                                initialValue: _selectedGovernorate,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedGovernorate = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FieldLabel(label: "العمر"),
                              const SizedBox(height: 8),
                              CustomTextFormField(
                                hint: "العمر",
                                validator: (value) => Validators.age(value),
                                textEditingController: _ageController,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.number,
                                borderRadius: 12,
                                verticalContentPadding: 16,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    UpdateUserInfoButton(
                      formKey: _formKey,
                      fullNameController: _fullNameController,
                      phoneController: _phoneController,
                      ageController: _ageController,
                      selectedGovernorate: _selectedGovernorate,
                    ),

                    Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
