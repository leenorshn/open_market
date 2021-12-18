import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:open_market/model/product.dart';

class ProductApi {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<List<Product>> getProduct() {
    var snapshot = db.collection("products").snapshots();

    return snapshot.map((event) {
      //print(event.docs[0].data());
      return event.docs.map((e) {
        //print(e.data());
        return Product.fromSnapshot(e);
      }).toList();
    });
  }

  void addProduct(Product p) async {
    await db.collection("products").add(p.toJson());
  }

  void deleteProduct(var id) async {
    await db.collection("products").doc(id).delete();
  }
}
