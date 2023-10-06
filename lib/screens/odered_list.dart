import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/ordered_model.dart';
import '../utils/appColors.dart';
import 'ordered_detail.dart';

class OrderedListScreen extends StatelessWidget {
  const OrderedListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Lịch sử đặt hàng"),
        backgroundColor: AppColors.kGreenColor,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Orders")
            .where('Email', isEqualTo: user?.email)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Đã xảy ra lỗi: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final orderHistories = snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            final createdAtString = data['CreatedAt'] as String;
            final createdAt =
                DateFormat('dd-MM-yyyy HH:mm:ss').parse(createdAtString);
            return OrderHistory(
              userName: data['UserName'],
              orderItems: List<Map<String, dynamic>>.from(data['OrderItems']),
              numberPhone: data['NumberPhone'],
              address: data['Address'],
              cashPayment: data['CashPayment'],
              status: data['Status'],
              createdAt: createdAt,
              email: data['Email'],
            );
          }).toList();

          return ListView.builder(
            itemCount: orderHistories.length,
            itemBuilder: (BuildContext context, int index) {
              final history = orderHistories[index];
              return ListTile(
                title: Text("Tên người đặt: ${history.userName}"),
                subtitle: Text("Thời gian: ${history.createdAt}"),
                trailing: Text("Tổng tiền: ${history.cashPayment}"),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => OrderDetailScreen(
                        userName: history.userName,
                        orderItems: history.orderItems,
                        numberPhone: history.numberPhone,
                        address: history.address,
                        cashPayment: history.cashPayment,
                        createdAt: history.createdAt,
                        email: history.email,
                        status: history.status,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
