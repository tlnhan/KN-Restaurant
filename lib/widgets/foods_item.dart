import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kn_restaurant/controllers/cart_controller.dart';
import 'package:kn_restaurant/utils/const.dart';
import '../controllers/food_controller.dart';
import '../utils/appColors.dart';

class FoodsItem extends StatefulWidget {
  const FoodsItem({Key? key}) : super(key: key);

  @override
  State<FoodsItem> createState() => _FoodsItemState();
}

class _FoodsItemState extends State<FoodsItem> {
  @override
  Widget build(BuildContext context) {
    Get.put(FoodController());
    Get.put(CartController());
    final FoodController foodController = Get.find();
    final CartController cartController = Get.find();

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Danh sách món ăn"),
          backgroundColor: AppColors.kGreenColor,
        ),
        body: ListView.builder(
            itemCount: foodController.foods.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 2.2,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    elevation: 3.0,
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 3.5,
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                child: Image.network(
                                  foodController.foods[index].img,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 6.0,
                              right: 6.0,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0)),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.star,
                                        color: Constants.ratingBG,
                                        size: 10.0,
                                      ),
                                      Text(
                                        "${foodController.foods[index].rating}",
                                        style: const TextStyle(
                                          fontSize: 10.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 6.0,
                              left: 6.0,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3.0)),
                                child: const Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Text(
                                    " OPEN",
                                    style: TextStyle(
                                      fontSize: 10.0,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 7.0),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              foodController.foods[index].name,
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w800,
                                color: AppColors.kGreenColor,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        const SizedBox(height: 7.0),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              foodController.foods[index].description,
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () => {
                                      cartController
                                          .addFood(foodController.foods[index]),
                                    },
                                    icon: const Icon(
                                        Icons.shopping_cart_checkout_outlined),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.kGreenColor,
                                    ),
                                    label: const Text(
                                      "Thêm vào giỏ hàng",
                                    ),
                                  ),
                                  const SizedBox(width: 50),
                                  Text(
                                    '${foodController.foods[index].price} VNĐ',
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.kGreenColor,
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
