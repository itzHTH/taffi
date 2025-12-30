import 'package:flutter/material.dart';
import 'package:taffi/core/utils/validators.dart';
import 'package:taffi/features/auth/screens/fill_personal_info_screen.dart';
import 'package:taffi/features/auth/widgets/custom_text_form_filed.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = false;

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
                        border: Border(
                          bottom: BorderSide(color: Colors.black38),
                        ),
                      ),
                      child: ClipRect(
                        child: Align(
                          alignment: Alignment.topCenter,
                          widthFactor: 0.8,
                          heightFactor: 0.8,
                          child: Image.asset("assets/images/doctor2.png"),
                        ),
                      ),
                    ),

                    SizedBox(height: 36),
                    Text(
                      "إنشاء حساب",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    SizedBox(height: 28),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36.0),
                      child: Column(
                        children: [
                          CustomTextFormFiled(
                            validator: (value) => Validators.username(value),
                            hint: "اسم المستخدم",
                            prefixIcon: "assets/images/person.svg",
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(height: 18),
                          CustomTextFormFiled(
                            validator: (value) => Validators.email(value),
                            hint: "البريد الالكتروني",
                            prefixIcon: "assets/images/email.svg",
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 18),
                          CustomTextFormFiled(
                            validator: (value) => Validators.password(value),
                            hint: "كلمه المرور",
                            prefixIcon: "assets/images/password.svg",
                            textEditingController: passwordController,
                            isPassword: true,
                            hidePasswordIcon: false,
                            isPasswordVisible: _isPasswordVisible,
                            onPasswordVisibilityChanged: (isVisible) {
                              setState(() {
                                _isPasswordVisible = isVisible;
                              });
                            },
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (value) {
                              FocusScope.of(context).nextFocus();
                            },
                          ),
                          SizedBox(height: 18),
                          CustomTextFormFiled(
                            validator: (value) => Validators.confrimPassword(
                              value,
                              passwordController.text,
                            ),
                            hint: "تأكيد كلمه المرور",
                            prefixIcon: "assets/images/password.svg",
                            isPassword: true,

                            isPasswordVisible: _isPasswordVisible,
                            onPasswordVisibilityChanged: (isVisible) {
                              setState(() {
                                _isPasswordVisible = isVisible;
                              });
                            },
                            scrollPadding: EdgeInsets.only(bottom: 150),
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (value) {
                              if (_key.currentState!.validate()) {
                                // TODO: Register Func
                              }
                            },
                          ),
                          SizedBox(height: 18),
                          ElevatedButton(
                            onPressed: () {
                              // if (_key.currentState!.validate()) {
                              // TODO: Register Func
                              // }

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FillPersonalInfoScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(MediaQuery.widthOf(context), 60),
                            ),
                            child: Text(
                              "انشاء الحساب",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: .center,
                            children: [
                              Text(
                                "لديك حساب بالفعل ؟",
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              SizedBox(width: 6),
                              TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "تسجيل دخول",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.displaySmall,
                                ),
                              ),
                            ],
                          ),
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
