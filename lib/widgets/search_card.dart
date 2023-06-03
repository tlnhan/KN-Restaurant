import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SearchCard extends StatefulWidget {
  const SearchCard({Key? key}) : super(key: key);

  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  String foodName = '';

  List<Map<String, dynamic>> data = [];

  addData() async {
    for (var element in data) {
      FirebaseFirestore.instance.collection('Foods').add(element);
    }
    if (kDebugMode) {
      print('Sản phẩm đã được thêm');
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchControl = TextEditingController();

    return Card(
      elevation: 6.0,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: TextField(
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
            hintText: "Search..",
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            suffixIcon: const Icon(
              Icons.filter_list,
              color: Colors.black,
            ),
            hintStyle: const TextStyle(
              fontSize: 15.0,
              color: Colors.black,
            ),
          ),
          onChanged: (val) {
            setState(() {
              foodName = val;
            });
          },
          maxLines: 1,
          controller: searchControl,
        ),
      ),
    );
  }
}
