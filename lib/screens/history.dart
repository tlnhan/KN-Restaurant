import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kn_restaurant/utils/appColors.dart';

import '../models/hisory_model.dart';
import 'order_detail.dart';

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
      // body: StreamBuilder<QuerySnapshot>(
      //   stream: FirebaseFirestore.instance.collection("Orders").snapshots(),
      //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      //     if (snapshot.hasError) {
      //       return Center(child: Text('Đã xảy ra lỗi: ${snapshot.error}'));
      //     }
      //
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(child: CircularProgressIndicator());
      //     }
      //
      //     final orderHistories = snapshot.data!.docs.map((doc) {
      //       final data = doc.data() as Map<String, dynamic>;
      //       return OrderHistory(
      //         userName: data['UserName'],
      //         orderItems: List<Map<String, dynamic>>.from(data['OrderItems']),
      //         numberPhone: data['NumberPhone'],
      //         address: data['Address'],
      //         cashPayment: data['CashPayment'],
      //         createdAt: (data['CreatedAt'] as Timestamp).toDate(),
      //       );
      //     }).toList();
      //
      //     return ListView.builder(
      //       itemCount: orderHistories.length,
      //       itemBuilder: (BuildContext context, int index) {
      //         final history = orderHistories[index];
      //         return ListTile(
      //           title: Text("Người đặt: ${history.userName}"),
      //           subtitle: Text("Thời gian: ${history.createdAt}"),
      //           trailing: Text("Tổng tiền: ${history.cashPayment}"),
      //             onTap: () {
      //               Navigator.of(context).push(
      //                 MaterialPageRoute(
      //                   builder: (context) => OrderDetailScreen(
      //                     userName: history.userName,
      //                     orderItems: history.orderItems,
      //                     numberPhone: history.numberPhone,
      //                     address: history.address,
      //                     cashPayment: history.cashPayment,
      //                     createdAt: history.createdAt,
      //                   ),
      //                 ),
      //               );
      //           },
      //         );
      //       },
      //     );
      //   },
      // ),
    );
  }
}
