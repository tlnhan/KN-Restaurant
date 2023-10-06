import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/food_controller.dart';
import '../models/food_model.dart';
import 'food_detailed.dart';

class SearchCard extends StatefulWidget {
  const SearchCard({Key? key}) : super(key: key);

  @override
  SearchCardState createState() => SearchCardState();
}

class SearchCardState extends State<SearchCard> {
  final FoodController foodController = Get.find();
  final TextEditingController searchController = TextEditingController();
  RxList<Food> searchResults = RxList<Food>();
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  searchResults.clear();
                  if (value.isNotEmpty) {
                    final keyword = value.toLowerCase();
                    searchResults.addAll(foodController.foods.where((food) =>
                        food.name.toLowerCase().contains(keyword) ||
                        food.description.toLowerCase().contains(keyword)));
                    isSearching = true;
                  } else {
                    isSearching = false;
                  }
                });
              },
              style: const TextStyle(
                fontSize: 15.0,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                hintText: "Tìm kiếm...",
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                hintStyle: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
              ),
              maxLines: 1,
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isSearching ? 170.0 : 0.0,
              child: Obx(() {
                final foodsToShow = searchResults.isNotEmpty
                    ? searchResults.toList()
                    : foodController.foods;
                return ListView.builder(
                  itemCount: foodsToShow.length,
                  itemBuilder: (context, index) {
                    final food = foodsToShow[index];
                    return ListTile(
                      title: Text(food.name),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FoodDetailPage(food: food),
                          ),
                        );
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
