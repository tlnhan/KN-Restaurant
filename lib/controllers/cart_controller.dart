import 'package:get/get.dart';
import 'package:kn_restaurant/models/food_model.dart';

class CartController extends GetxController {
  final _foods = {}.obs;

  void addFood(Food food) {
    if (_foods.containsKey(food)) {
      _foods[food] += 1;
    } else {
      _foods[food] = 1;
    }

    Get.snackbar(
      "Đơn hàng đã được thêm",
      "Bạn vừa thêm ${_foods[food]} ${food.name} vào giỏ hàng",
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
    );
  }

  get foods => _foods;

  void removeFood(Food food) {
    if (_foods.containsKey(food) && _foods[food] == 1) {
      _foods.removeWhere((key, value) => key == food);
    } else {
      _foods[food] -= 1;
    }
  }

  void checkoutFood(Food food) async {
    Get.snackbar(
      "Đơn hàng đã được thanh toán",
      "Bạn vừa thanh toán ${_foods[food]} ${food.name} \n Vui lòng kiểm tra điện thoại của bạn \n Delivery của chúng tôi sẽ đến trong ít phút",
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
    );

    _foods.clear();
  }

  get foodSubtotal =>
      _foods.entries.map((food) => food.key.price * food.value).toList();

  get total => _foods.entries
      .map((food) => food.key.price * food.value)
      .toList()
      .reduce((value, element) => value + element)
      .toString();
}
