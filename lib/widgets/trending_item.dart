import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kn_restaurant/widgets/foods_item.dart';
import 'package:kn_restaurant/utils/const.dart';
import '../utils/appColors.dart';

class TrendingItem extends StatefulWidget {
  const TrendingItem({super.key});


  @override
  State<TrendingItem> createState() => _TrendingItemState();
}

class _TrendingItemState extends State<TrendingItem> {

  final _userStream = FirebaseFirestore.instance.collection("TrendingRestaurants").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Danh sách nhà hàng"),
        backgroundColor: AppColors.kGreenColor,
      ),
      body: StreamBuilder(
        stream: _userStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Kết nối thất bại...");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Đang tải...");
          }

          var docs = snapshot.data!.docs;
          return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FoodsItem()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 2.6,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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
                                      docs[index]['img'],
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
                                            "${docs[index]['rating']}",
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
                                  docs[index]['title'],
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
                                  docs[index]['address'],
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
