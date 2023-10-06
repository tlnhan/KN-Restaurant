import 'package:flutter/material.dart';
import 'package:kn_restaurant/utils/categories.dart';

import '../widgets/trending_item.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: const Text('Danh mục nhà hàng'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          5.0,
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TrendingItem()),
            );
          },
          child: GridView.count(
            crossAxisCount: 2,
            children: List.generate(
              categories.length,
              (index) {
                var cat = categories[index];
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Stack(
                      children: <Widget>[
                        Image.asset(
                          cat["img"],
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.height,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: const [0.2, 0.7],
                              colors: [
                                cat['color1'],
                                cat['color2'],
                              ],
                            ),
                          ),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.height,
                        ),
                        Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.height,
                            padding: const EdgeInsets.all(1),
                            child: Center(
                              child: Text(
                                cat["name"],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
