import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:taffi/core/utils/validators.dart';
import 'package:taffi/features/auth/providers/login_provider.dart';
import 'package:taffi/features/auth/providers/register_provider.dart';
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
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login(BuildContext context) async {
    FocusScope.of(context).unfocus();
    bool result = await context.read<LoginProvider>().loginByEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
      saveInfo: _saveInfo,
    );

    if (!context.mounted) return;
    if (result) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            context.read<LoginProvider>().errorMessage ?? "حدث خطا , يرجى المحاولة مرة اخرى ",
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginProvider(),
      child: GestureDetector(
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
                              textEditingController: _emailController,
                              hint: "البريد الالكتروني",
                              prefixIcon: "assets/images/email.svg",
                              verticalContentPadding: 20,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(height: 28),
                            Consumer<LoginProvider>(
                              builder: (context, provider, child) => CustomTextFormFiled(
                                validator: (value) => Validators.password(value),
                                textEditingController: _passwordController,
                                hint: "كلمه المرور",
                                prefixIcon: "assets/images/password.svg",
                                isPassword: true,
                                verticalContentPadding: 20,
                                hidePasswordIcon: false,

                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (value) async {
                                  if (_key.currentState!.validate()) {
                                    await _login(context);
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 28),
                            Consumer<LoginProvider>(
                              builder: (context, provider, child) => ElevatedButton(
                                onPressed: () async {
                                  if (_key.currentState!.validate()) {
                                    await _login(context);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(MediaQuery.widthOf(context), 60),
                                ),
                                child: provider.isLoading
                                    ? const CircularProgressIndicator()
                                    : Text(
                                        "تسجيل دخول",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                                      ),
                              ),
                            ),
                            SizedBox(height: 8),
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
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(child: Container(height: 1, color: Colors.black45)),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: Text("أو"),
                                ),
                                Expanded(child: Container(height: 1, color: Colors.black45)),
                              ],
                            ),
                            SizedBox(height: 16),

                            Builder(
                              builder: (context) => InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () async {
                                  final result = await context
                                      .read<LoginProvider>()
                                      .loginWithGoogle();
                                  if (!context.mounted) return;
                                  if (result) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => MainScreen()),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(context.read<LoginProvider>().errorMessage!),
                                      ),
                                    );
                                  }
                                },

                                child: SvgPicture.asset("assets/images/google.svg", height: 22),
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
                                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChangeNotifierProvider(
                                          create: (context) => RegisterProvider(),
                                          child: RegisterScreen(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "انشاء حساب",
                                    style: Theme.of(context).textTheme.displaySmall,
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
      ),
    );
  }
}
