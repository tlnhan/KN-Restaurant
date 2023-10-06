import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kn_restaurant/models/food_model.dart';

class FirestoreDB {
  final FirebaseFirestore _firestoreDB = FirebaseFirestore.instance;

  Stream<List<Food>> getAllFoods() {
    return _firestoreDB.collection('Foods').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Food.fromSnapshot(doc)).toList();
    });
  }
}
