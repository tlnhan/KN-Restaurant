import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kn_restaurant/utils/appColors.dart';
import 'login.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Tài khoản của bạn"),
        backgroundColor: AppColors.kGreenColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(60.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2.0,
              blurRadius: 5.0,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50.0,
              backgroundImage: NetworkImage(
                'https://inkythuatso.com/uploads/thumbnails/800/2023/03/9-anh-dai-dien-trang-inkythuatso-03-15-27-03.jpg',
              ),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              decoration: InputDecoration(
                enabled: false,
                labelText: 'ID:  ${user.uid}',
              ),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Họ và tên:  ',
              ),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            TextFormField(
              decoration: InputDecoration(
                enabled: false,
                labelText: 'Email:  ${user.email}',
              ),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            TextFormField(
              decoration: InputDecoration(
                enabled: false,
                labelText: 'Trạng thái:  ${user.emailVerified}',
              ),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Số điện thoại:  ',
              ),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Địa chỉ:  ',
              ),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            TextFormField(
              decoration: InputDecoration(
                enabled: false,
                labelText: 'Ngày tạo:  ${user.metadata.creationTime}',
              ),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {

                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(AppColors.kGreenColor)
                  ),
                  label: const Text('Cập nhật'),
                  icon: const Icon(Icons.upload_sharp),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    FirebaseAuth.instance.signOut();
                    await Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(AppColors.kGreenColor)
                  ),
                  label: const Text('Đăng xuất'),
                  icon: const Icon(Icons.logout_outlined),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
