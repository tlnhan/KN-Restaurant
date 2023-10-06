import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kn_restaurant/screens/login.dart';
import 'package:kn_restaurant/utils/appColors.dart';
import 'package:kn_restaurant/utils/utils.dart';

import 'main_screen.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());

      Utils.showSnackBar("Email lấy lại mật khẩu đã được gửi");
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Utils.showSnackBar(e.message);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Quên mật khẩu"),
        backgroundColor: AppColors.kGreenColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Nhập email để lấy lại password",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, color: AppColors.kGreenColor),
              ),
              const SizedBox(
                height: 20,
              ),
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
                  prefixIcon: Icon(
                    Icons.person,
                    color: AppColors.kGreenColor,
                  ),
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
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(
                    50,
                  ),
                  backgroundColor: AppColors.kGreenColor,
                ),
                onPressed: () {
                  resetPassword();
                },
                icon: const Icon(Icons.password_outlined),
                label: const Text(
                  "Lấy lại mật khẩu",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(
                    50,
                  ),
                  backgroundColor: AppColors.kGreenColor,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainScreen()));
                },
                icon: const Icon(Icons.home),
                label: const Text(
                  "Trở về trang chủ",
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
