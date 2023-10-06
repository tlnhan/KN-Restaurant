import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  final String name;
  final String description;
  final String img;
  final num price;
  final num rating;
  final String restaurant;
  final String address;

  const Food({
    required this.name,
    required this.description,
    required this.img,
    required this.price,
    required this.rating,
    required this.restaurant,
    required this.address,
  });

  static Food fromSnapshot(DocumentSnapshot snap) {
    Food food = Food(
      name: snap['name'],
      description: snap['description'],
      img: snap['img'],
      price: snap['price'],
      rating: snap['rating'],
      restaurant: snap['restaurant'],
      address: snap['address'],
    );
    return food;
  }
}
