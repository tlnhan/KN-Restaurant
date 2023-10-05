import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kn_restaurant/screens/odered_list.dart';
import 'package:kn_restaurant/screens/register.dart';
import 'package:kn_restaurant/utils/appColors.dart';

import 'login.dart';

class Histories extends StatelessWidget {
  const Histories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Có gì đó sai ở đây!'),
          );
        } else if (snapshot.hasData) {
          return const OrderedListScreen();
        } else {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: const Text("Lịch sử đặt hàng"),
              backgroundColor: AppColors.kGreenColor,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/history.jpg"),
                  const SizedBox(height: 16),
                  const Text(
                    "Bạn chưa đăng nhập ?",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 30, color: AppColors.kGreenColor),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.kGreenColor)),
                        child: const Text('Đăng nhập'),
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
