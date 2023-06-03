import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kn_restaurant/screens/main_screen.dart';
import 'package:kn_restaurant/utils/utils.dart';
import '../utils/appColors.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {

  bool isEmailVerified = false;
  bool canResendEmail = false;
  final user = FirebaseAuth.instance.currentUser!;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified(),);
    }
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  Future checkEmailVerified() async {

    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) =>
      isEmailVerified
          ? const MainScreen()
          : Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text("Xác thực email"),
          backgroundColor: AppColors.kGreenColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Chúc mừng bạn đã đăng nhập thành công', style: TextStyle(fontSize: 20),),
                    const SizedBox(height: 20,),
                    const Text('Email xác minh tài khoản đã được gửi tới', style: TextStyle(fontSize: 20),),
                    const SizedBox(height: 20,),
                    Text(user.email!, style: const TextStyle(fontSize: 20, color: AppColors.kGreenColor),),
                    const SizedBox(height: 20,),
                    const Text('Hãy kiểm tra hộp thư của bạn', style: TextStyle(fontSize: 20),),
                  ],
                ),
                const SizedBox(height: 20.0,),
                ElevatedButton.icon(
                  icon: const Icon(Icons.email_outlined),
                  onPressed: () async {
                    canResendEmail ? sendVerificationEmail() : null;
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.kGreenColor,
                  ),
                  label: const Text("Gửi lại email xác minh"),
                ),
                const SizedBox(height: 20.0,),
                ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () async {
                  FirebaseAuth.instance.signOut();
                  await Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const MainScreen()));
                },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.kGreenColor,
                  ),
                  label: const Text("Thoát"),
                ),
              ],
            ),
          ),
        ),
      );
}
