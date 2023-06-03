import 'package:flutter/material.dart';

import '../utils/appColors.dart';

class Histories extends StatelessWidget {
  const Histories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Lịch sử"),
        backgroundColor: AppColors.kGreenColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
