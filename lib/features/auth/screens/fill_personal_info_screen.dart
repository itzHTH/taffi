import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:taffi/core/constants/app_constants.dart';
import 'package:taffi/core/theme/app_colors.dart';
import 'package:taffi/core/utils/validators.dart';
import 'package:taffi/features/auth/providers/register_provider.dart';
import 'package:taffi/features/auth/widgets/custom_text_form_filed.dart';
import 'package:taffi/features/home/screens/main_screen.dart';

class FillPersonalInfoScreen extends StatefulWidget {
  const FillPersonalInfoScreen({super.key});

  @override
  State<FillPersonalInfoScreen> createState() => _FillPersonalInfoScreenState();
}

class _FillPersonalInfoScreenState extends State<FillPersonalInfoScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  String dropdownValue = AppConstants.iraqGovernorates.first;

  late final TextEditingController fullNameController;
  late final TextEditingController phoneController;
  late final TextEditingController ageController;

  @override
  void initState() {
    fullNameController = TextEditingController();
    phoneController = TextEditingController();
    ageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    ageController.dispose();
    super.dispose();
  }

  Future<void> _registerAndLogin(BuildContext context) async {
    final registerProvider = Provider.of<RegisterProvider>(context, listen: false);

    final result = await registerProvider.registerAndLogin(
      name: fullNameController.text,
      phone: phoneController.text,
      age: ageController.text,
      governorate: dropdownValue,
    );

    if (!context.mounted) return;

    if (result) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const MainScreen()));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(registerProvider.errorMessage ?? "حدث خطأ")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Form(
            key: _key,
            child: SingleChildScrollView(
              reverse: true,
              child: Center(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.widthOf(context),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.black38)),
                      ),
                      child: ClipRect(
                        child: Align(
                          alignment: Alignment.topCenter,
                          widthFactor: 0.8,
                          heightFactor: 0.8,
                          child: Image.asset("assets/images/doctor1.png"),
                        ),
                      ),
                    ),
                    SizedBox(height: 36),
                    Text("المعلومات الشخصية", style: Theme.of(context).textTheme.labelSmall),
                    SizedBox(height: 28),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36.0),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("الأسم الثلاثي", style: Theme.of(context).textTheme.titleSmall),
                              CustomTextFormFiled(
                                validator: (value) => Validators.fullName(value),
                                hint: "ادخل اسمك الثلاثي هنا",
                                textEditingController: fullNameController,
                                textInputAction: TextInputAction.next,
                                borderRadius: 6,
                              ),
                            ],
                          ),
                          SizedBox(height: 14),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("رقم الهاتف", style: Theme.of(context).textTheme.titleSmall),
                              CustomTextFormFiled(
                                validator: (value) => Validators.phone(value),
                                hint: "ادخل رقم هاتفك هنا",

                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.phone,
                                borderRadius: 6,
                                textEditingController: phoneController,
                              ),
                            ],
                          ),
                          SizedBox(height: 14),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("المحافظة", style: Theme.of(context).textTheme.titleSmall),
                                    DropdownMenu<String>(
                                      dropdownMenuEntries: AppConstants.iraqGovernorates.map((e) {
                                        return DropdownMenuEntry(value: e, label: e);
                                      }).toList(),
                                      trailingIcon: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: AppColors.primary,
                                      ),

                                      selectedTrailingIcon: Icon(
                                        Icons.keyboard_arrow_up_rounded,
                                        color: AppColors.primary,
                                      ),
                                      initialSelection: dropdownValue,
                                      inputDecorationTheme: InputDecorationTheme(
                                        // isDense: ,
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                                        constraints: BoxConstraints.tight(
                                          const Size.fromHeight(49),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(6),
                                          borderSide: const BorderSide(
                                            color: AppColors.primary,
                                            width: 1.8,
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(6),
                                          borderSide: const BorderSide(
                                            color: AppColors.primary,
                                            width: 1.8,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(6),
                                          borderSide: const BorderSide(
                                            color: AppColors.primary,
                                            width: 1.8,
                                          ),
                                        ),
                                      ),
                                      menuHeight: 150,

                                      textStyle: Theme.of(context).textTheme.titleSmall,
                                      menuStyle: MenuStyle(
                                        backgroundColor: WidgetStatePropertyAll(
                                          AppColors.background,
                                        ),
                                        alignment: Alignment.topRight,
                                      ),
                                      onSelected: (value) {
                                        dropdownValue = value!;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("العمر", style: Theme.of(context).textTheme.titleSmall),
                                    CustomTextFormFiled(
                                      validator: (value) => Validators.age(value),
                                      hint: "ادخل العمر هنا",
                                      scrollPadding: EdgeInsets.only(bottom: 150),
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.done,
                                      borderRadius: 6,
                                      textEditingController: ageController,
                                      onFieldSubmitted: (value) async {
                                        if (_key.currentState!.validate()) {
                                          await _registerAndLogin(context);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 70),
                          Consumer<RegisterProvider>(
                            builder: (context, provider, child) {
                              return ElevatedButton(
                                onPressed: () async {
                                  if (_key.currentState!.validate()) {
                                    await _registerAndLogin(context);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(MediaQuery.widthOf(context), 60),
                                ),
                                child: provider.isLoading
                                    ? CircularProgressIndicator()
                                    : Text(
                                        "حفظ المعلومات",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                                      ),
                              );
                            },
                          ),
                          SizedBox(height: 6),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
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
