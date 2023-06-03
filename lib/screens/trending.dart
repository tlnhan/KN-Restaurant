import 'package:flutter/material.dart';
import 'package:kn_restaurant/utils/restaurants.dart';
import 'package:kn_restaurant/widgets/search_card.dart';
import 'package:kn_restaurant/widgets/trending_item.dart';

class Trending extends StatelessWidget {
  const Trending({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 10.0,
        ),
        child: ListView(
          children: <Widget>[
            const SearchCard(),
            const SizedBox(height: 10.0),
            ListView.builder(
              primary: false,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: restaurants == null ? 0 : restaurants.length,
              itemBuilder: (BuildContext context, int index) {

                return const TrendingItem();
              },
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
