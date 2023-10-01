import 'package:flutter/material.dart';

import '../utils/appColors.dart';

class OrderDetailScreen extends StatelessWidget {
  final String userName;
  final List<Map<String, dynamic>> orderItems;
  final String numberPhone;
  final String address;
  final String cashPayment;
  final DateTime createdAt;

  OrderDetailScreen({
    required this.userName,
    required this.orderItems,
    required this.numberPhone,
    required this.address,
    required this.cashPayment,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Chi tiết đơn hàng"),
        backgroundColor: AppColors.kGreenColor,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text("Người đặt: $userName"),
          ),
          ListTile(
            title: Text("Số điện thoại: $numberPhone"),
          ),
          ListTile(
            title: Text("Địa chỉ: $address"),
          ),
          ListTile(
            title: Text("Tổng tiền: $cashPayment"),
          ),
          ListTile(
            title: Text("Thời gian đặt hàng: ${createdAt.toLocal()}"),
          ),
          ListTile(
            title: Text("Danh sách sản phẩm:"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: orderItems.map((item) {
                return ListTile(
                  title: Text(item['foodName']),
                  subtitle: Text("Số lượng: ${item['quantity']}"),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
