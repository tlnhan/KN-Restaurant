import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kn_restaurant/screens/main_screen.dart';
import 'package:kn_restaurant/utils/appColors.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
{

  startTimer()
  {
    Timer(const Duration(seconds: 3), () async {
      Navigator.push(context, MaterialPageRoute(builder: (c)=> const MainScreen()));
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/splash_screen.jpg"),
              const SizedBox(height: 10,),
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  "Chào mừng đến với \n KN Restaurant",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 30,
                    letterSpacing: 3,
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: AppColors.kGreenColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
