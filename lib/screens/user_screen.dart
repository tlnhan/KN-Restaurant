import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../utils/appColors.dart';
import 'login.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => UserScreenState();
}

class UserScreenState extends State<UserScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUserProfile();
  }

  void loadUserProfile() async {
    final userProfileRef =
        FirebaseFirestore.instance.collection('UserProfiles').doc(user.uid);

    try {
      final userProfileDoc = await userProfileRef.get();
      if (userProfileDoc.exists) {
        final data = userProfileDoc.data() as Map<String, dynamic>;
        fullNameController.text = data['fullName'] ?? '';
        phoneNumberController.text = data['phoneNumber'] ?? '';
        addressController.text = data['address'] ?? '';
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error loading user profile: $error');
      }
    }
  }

  Future<void> saveOrUpdateUserProfile() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final userProfileRef =
          FirebaseFirestore.instance.collection('UserProfiles').doc(user.uid);

      final userProfileData = {
        'id': user.uid,
        'fullName': fullNameController.text,
        'email': user.email,
        'status': user.emailVerified,
        'phoneNumber': phoneNumberController.text,
        'address': addressController.text,
        'createdDateTime': DateFormat('dd-MM-yyyy HH:mm:ss')
            .format(user.metadata.creationTime!.toLocal()),
      };

      try {
        await userProfileRef.set(userProfileData, SetOptions(merge: true));
        Get.snackbar('Cập nhật thành công', 'Thông tin hồ sơ đã được lưu.',
            snackPosition: SnackPosition.TOP);
      } catch (error) {
        if (kDebugMode) {
          print('Error saving user profile: $error');
        }
        Get.snackbar('Lỗi', 'Đã xảy ra lỗi khi cập nhật hồ sơ.',
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

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
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(20.0),
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 90,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Họ và tên:  ',
                ),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
                controller: fullNameController,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email:  ${user.email}',
                ),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                readOnly: true,
              ),
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText:
                      'Trạng thái:  ${user.emailVerified ? "Đã xác thực" : "Chưa xác thực"}',
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
                textAlign: TextAlign.left,
                controller: phoneNumberController,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Địa chỉ:  ',
                ),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
                controller: addressController,
              ),
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText:
                      'Ngày tạo:  ${DateFormat('dd-MM-yyyy HH:mm:ss').format(user.metadata.creationTime!.toLocal())}',
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
                      saveOrUpdateUserProfile();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          AppColors.kGreenColor),
                    ),
                    label: const Text('Cập nhật'),
                    icon: const Icon(Icons.upload_sharp),
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      FirebaseAuth.instance.signOut();
                      Get.snackbar(
                        "ĐĂNG XUẤT THÀNH CÔNG",
                        "Chúng tôi hy vọng sẽ gặp lại bạn",
                        snackPosition: SnackPosition.TOP,
                        duration: const Duration(seconds: 2),
                      );
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppColors.kGreenColor)),
                    label: const Text('Đăng xuất'),
                    icon: const Icon(Icons.logout_outlined),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
