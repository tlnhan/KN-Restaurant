import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kn_restaurant/screens/forgot_password_screen.dart';
import 'package:kn_restaurant/screens/register.dart';
import 'package:kn_restaurant/utils/appColors.dart';
import '../utils/utils.dart';
import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  Future logIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim()
      );

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen()));

    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
        Utils.showSnackBar(e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/login.png'),
              const SizedBox(height: 20,),
              const Text("Đăng Nhập",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800,
                    color: AppColors.kGreenColor),),
              const SizedBox(height: 20,),
              TextFormField(
                controller: emailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Hãy điền email của bạn";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined, color: AppColors.kGreenColor,),
                  hintText: 'Email...',
                  focusColor: AppColors.kGreenColor,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.kGreenColor,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Hãy điền password của bạn";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.key_outlined, color: AppColors.kGreenColor,),
                  hintText: 'Mật khẩu...',
                  focusColor: AppColors.kGreenColor,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.kGreenColor,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      logIn();
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppColors.kGreenColor)
                    ),
                    child: const Text('Đăng nhập'),
                  ),
                  const SizedBox(width: 18,),
                  const Text("Hoặc", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.kGreenColor),),
                  const SizedBox(width: 18,),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const RegisterScreen()));
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppColors.kGreenColor)
                    ),
                    child: const Text('Đăng ký'),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const ForgotPassword()));
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppColors.kGreenColor)
                    ),
                    child: const Text('Quên mật khẩu ?'),
                  ),
                  const SizedBox(width: 20,),
                  ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const MainScreen()));
                    },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.kGreenColor)
                      ),
                      child: const Text('Trở về trang chủ'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
