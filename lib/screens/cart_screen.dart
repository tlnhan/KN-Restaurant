import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kn_restaurant/controllers/cart_controller.dart';
import 'package:kn_restaurant/models/food_model.dart';
import '../controllers/food_controller.dart';
import '../utils/appColors.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CartController());
    final CartController controller = Get.find();

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
                height: 390,
                child: ListView.builder(
                    itemCount: controller.foods.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CartFoodCard(
                        controller: controller,
                        food: controller.foods.keys.toList()[index],
                        quantity: controller.foods.values.toList()[index],
                        index: index,
                      );
                    }),
              ),
              SizedBox(
                height: 290,
                child: ListView.builder(
                    itemCount: controller.foods.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CartTotal(
                        controller: controller,
                        food: controller.foods.keys.toList()[index],
                        index: index,
                        quantity: controller.foods.values.toList()[index],
                      );
                    }),
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
                  controller.addFood(food);
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

class CartTotal extends StatelessWidget {
  final CartController controller;
  final Food food;
  final int index;
  final int quantity;

  const CartTotal({
    Key? key,
    required this.controller,
    required this.food,
    required this.index,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CartController());
    Get.put(FoodController());
    final CartController cartController = Get.find();
    final TextEditingController userNameController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController numberPhoneController = TextEditingController();

    return Obx(
      () => Container(
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
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tổng cộng:',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.kGreenColor,
                    ),
                  ),
                  Text(
                    '${cartController.total} VNĐ',
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
              onPressed: () {
                Map<String, dynamic> data = {
                  "userName": userNameController.text,
                  "foods": food.name,
                  "quantity": quantity,
                  "numberPhone": numberPhoneController.text,
                  "address": addressController.text,
                  "cashPayment": controller.total.toString(),
                  "createdAt": DateTime.now(),
                };
                FirebaseFirestore.instance.collection("Orders").add(data);
                controller.checkoutFood(food);
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
