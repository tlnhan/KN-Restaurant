import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kn_restaurant/controllers/cart_controller.dart';
import 'package:kn_restaurant/models/food_model.dart';
import '../utils/appColors.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CartController());
    final CartController controller = Get.find();

    if (controller.foods.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text("Giỏ hàng"),
          backgroundColor: AppColors.kGreenColor,
        ),
      );
    }

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text("Giỏ hàng"),
          backgroundColor: AppColors.kGreenColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 330,
                child: ListView.builder(
                  itemCount: controller.foods.length,
                  itemBuilder: (BuildContext context, int index) {
                    final keys = controller.foods.keys.toList();
                    final values = controller.foods.values.toList();
                    return CartFoodCard(
                      controller: controller,
                      food: keys[index],
                      quantity: values[index],
                      index: index,
                    );
                  },
                ),
              ),
              if (controller.foods.isNotEmpty)
                CartTotal(
                  controller: controller,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartFoodCard extends StatelessWidget {
  final CartController controller;
  final Food food;
  final int quantity;
  final int index;

  const CartFoodCard({
    Key? key,
    required this.controller,
    required this.food,
    required this.quantity,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                  food.img,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(child: Text(food.name)),
              IconButton(
                onPressed: () {
                  controller.removeFood(food);
                },
                icon: const Icon(Icons.remove_circle),
              ),
              Text("$quantity"),
              IconButton(
                onPressed: () {
                  controller.addCardFood(food);
                },
                icon: const Icon(Icons.add_circle),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CartTotal extends StatefulWidget {
  final CartController controller;

  const CartTotal({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  CartTotalState createState() => CartTotalState();
}

class CartTotalState extends State<CartTotal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController numberPhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            TextFormField(
              controller: userNameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                  color: AppColors.kGreenColor,
                ),
                hintText: 'Họ và Tên...',
                focusColor: AppColors.kGreenColor,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.kGreenColor,
                    width: 2,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Họ và Tên không được để trống';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: addressController,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.location_on_outlined,
                  color: AppColors.kGreenColor,
                ),
                hintText: 'Địa chỉ...',
                focusColor: AppColors.kGreenColor,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.kGreenColor,
                    width: 2,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Địa chỉ không được để trống';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: numberPhoneController,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.phone,
                  color: AppColors.kGreenColor,
                ),
                hintText: 'Số điện thoại...',
                focusColor: AppColors.kGreenColor,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.kGreenColor,
                    width: 2,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Số điện thoại không được để trống';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 55),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tổng:',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.kGreenColor,
                    ),
                  ),
                  Text(
                    '${widget.controller.total} VNĐ',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.kGreenColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              onPressed: () async {
                if (_formKey.currentState!.validate() &&
                    widget.controller.foods.isNotEmpty) {
                  List<Map<String, dynamic>> orderItems = [];
                  final food = widget.controller.foods.keys.first;
                  widget.controller.foods.forEach((food, quantity) {
                    orderItems.add({
                      "foodName": food.name,
                      "quantity": quantity,
                      "restaurant": food.restaurant,
                    });
                  });

                  final currentUser = FirebaseAuth.instance.currentUser;

                  Map<String, dynamic> data = {
                    "UserName": userNameController.text,
                    "OrderItems": orderItems,
                    "NumberPhone": numberPhoneController.text,
                    "Address": addressController.text,
                    "CashPayment": widget.controller.total.toString(),
                    "CreatedAt": DateFormat('dd-MM-yyyy HH:mm:ss')
                        .format(DateTime.now()),
                    "Status": "Đang giao",
                    "Email":
                        "${currentUser != null ? currentUser.email : 'Vãng lai'}"
                  };

                  await FirebaseFirestore.instance
                      .collection("Orders")
                      .add(data);
                  widget.controller.checkoutFood(food);
                }
              },
              icon: const Icon(Icons.monetization_on_outlined),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.kGreenColor,
              ),
              label: const Text(
                "Đặt đơn hàng",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
