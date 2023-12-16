import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String? id;
  String? title;
  String? description;
  String? category;
  String? details;
  double? price;
  List? images;
  List? sizes;

  ProductData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;
    title = snapshot.get("title");
    description = snapshot.get("description");
    details = snapshot.get('details');
    price = snapshot.get("price") + 0.0;
    images = snapshot.get("images");
    sizes = snapshot.get("sizes");
  }

  Map<String, dynamic> toResumedMap(){
    return {
      "title": title,
      'price': price
    };
  }
}
