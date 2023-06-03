import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kn_restaurant/screens/login.dart';
import 'package:kn_restaurant/screens/register.dart';
import 'package:kn_restaurant/screens/user_screen.dart';
import 'package:kn_restaurant/utils/appColors.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
       if (snapshot.connectionState == ConnectionState.waiting) {
         return const Center(child: CircularProgressIndicator(),);
       } else if (snapshot.hasError) {
         return const Center(child: Text('Có gì đó sai ở đây!'),);
       } else  if (snapshot.hasData) {
         return const UserScreen();
       } else {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: const Text("Tài khoản của bạn"),
              backgroundColor: AppColors.kGreenColor,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/become_member.png"),
                  const SizedBox(height: 16),
                  const Text(
                    "Bạn chưa có tài khoản ?",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, color: AppColors.kGreenColor),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  const LoginScreen()));
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(AppColors.kGreenColor)
                        ),
                        child: const Text('Đăng nhập'),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(AppColors.kGreenColor)
                        ),
                        child: const Text('Đăng ký'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}