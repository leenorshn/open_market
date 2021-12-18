import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_market/api/product_api.dart';
import 'package:open_market/model/product.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  var name = "";
  var price = 0;
  var imgUrl = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Product"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            TextField(
              onChanged: (v) {
                setState(() {
                  name = v;
                });
              },
              decoration: InputDecoration(
                  label: const Text("Nom du produit"),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.all(8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              onChanged: (v) {
                setState(() {
                  price = int.parse(v);
                });
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  label: const Text("Prix "),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.all(8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              onChanged: (v) {
                setState(() {
                  imgUrl = v;
                });
              },
              decoration: InputDecoration(
                  label: const Text("Image url"),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.all(8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
            const SizedBox(
              height: 48,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                  horizontal: 56,
                  vertical: 14,
                )),
                onPressed: () {
                  Product p = Product(name: name, price: price, imgUrl: imgUrl);
                  ProductApi().addProduct(p);
                },
                child: const Text("Save")),
          ],
        ),
      ),
    );
  }
}
