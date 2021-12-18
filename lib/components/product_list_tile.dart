import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_market/api/product_api.dart';
import 'package:open_market/model/product.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile({Key? key, required this.onTap, required this.product})
      : super(key: key);

  final VoidCallback onTap;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Card(
            margin: EdgeInsets.zero,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Image.asset(product.imgUrl),
                  const SizedBox(
                    height: 16,
                  ),
                  const Divider(
                    height: 2,
                  ),
                  ListTile(
                    title: Text(product.name),
                    subtitle: Text(product.price.toString()),
                    trailing: const Icon(CupertinoIcons.suit_heart),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            right: 2,
            top: 10,
            child: IconButton(
              onPressed: () {
                ProductApi().deleteProduct(product.reference!.id);
              },
              icon: const Icon(CupertinoIcons.delete),
            ),
          ),
        ],
      ),
    );
  }
}
