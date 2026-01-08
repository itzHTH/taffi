import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taffi/core/utils/validators.dart';
import 'package:taffi/features/auth/screens/register_screen.dart';
import 'package:taffi/features/auth/widgets/custom_text_form_filed.dart';
import 'package:taffi/features/home/screens/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool _saveInfo = true;

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
                          child: Image.asset("assets/images/doctor1.png"),
                        ),
                      ),
                    ),

                    SizedBox(height: 36),
                    Text(
                      "أهلاً بعودتك الى تعافي سجل الدخول الأن",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36.0),
                      child: Column(
                        children: [
                          SizedBox(height: 28),
                          CustomTextFormFiled(
                            validator: (value) => Validators.email(value),
                            hint: "البريد الالكتروني",
                            prefixIcon: "assets/images/email.svg",
                            verticalContentPadding: 20,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 28),
                          CustomTextFormFiled(
                            validator: (value) => Validators.password(value),
                            hint: "كلمه المرور",
                            prefixIcon: "assets/images/password.svg",
                            isPassword: true,
                            verticalContentPadding: 20,
                            hidePasswordIcon: false,

                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (value) {
                              if (_key.currentState!.validate()) {
                                // TODO: Login Func
                              }
                            },
                          ),
                          SizedBox(height: 28),
                          ElevatedButton(
                            onPressed: () {
                              if (_key.currentState!.validate()) {
                                // TODO: Login Func

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MainScreen(),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(MediaQuery.widthOf(context), 60),
                            ),
                            child: Text(
                              "تسجيل دخول",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: 6),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10,
                                width: 10,
                                child: Checkbox(
                                  value: _saveInfo,
                                  onChanged: (value) {
                                    setState(() {
                                      _saveInfo = !_saveInfo;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: 10),

                              Text(
                                "حفظ معلومات الدخول",
                                style: Theme.of(context).textTheme.displaySmall,
                              ),

                              SizedBox(width: 40),
                              TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                ),
                                onPressed: () {},
                                child: Text(
                                  "هل نسيت كلمه المرور ؟",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(color: Color(0xFF9F9292)),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 1,
                                  color: Colors.black45,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Text("أو"),
                              ),
                              Expanded(
                                child: Container(
                                  height: 1,
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          GestureDetector(
                            onTap: () {},
                            child: SvgPicture.asset(
                              "assets/images/google.svg",
                              height: 22,
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: .center,
                            children: [
                              Text(
                                "ليس لديك حساب ؟",
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              SizedBox(width: 6),
                              TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegisterScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "انشاء حساب",
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
