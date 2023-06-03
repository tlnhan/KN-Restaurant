import 'package:get/get.dart';
import 'package:kn_restaurant/services/firebase_db.dart';

import '../models/food_model.dart';

class FoodController extends GetxController {
  final foods = <Food>[].obs;

  @override
  void onInit() {
    foods.bindStream(FirestoreDB().getAllFoods());
    super.onInit();
  }
}