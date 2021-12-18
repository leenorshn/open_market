import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  late String name;
  late int price;
  late String imgUrl;
  String? description;
  DocumentReference? reference;

  Product(
      {required this.name,
      required this.price,
      required this.imgUrl,
      this.description,
      this.reference});

  Product.fromSnapshot(DocumentSnapshot doc)
      : this.fromJson(doc.data(), reference: doc.reference);

  Product.fromJson(var json, {this.reference}) {
    name = json['name'];
    price = json['price'];
    imgUrl = json['imgUrl'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['name'] = name;
    data['price'] = price;
    data['imgUrl'] = imgUrl;
    data['description'] = description;
    return data;
  }
}
