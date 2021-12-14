import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_market/model/product.dart';

class ProductGridTile extends StatelessWidget {
  const ProductGridTile({Key? key, required this.onTap, required this.product})
      : super(key: key);

  final VoidCallback onTap;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Expanded(
                child: Image.network(product.imgUrl),
              ),
              const SizedBox(
                height: 16,
              ),
              const Divider(
                height: 2,
              ),
              ListTile(
                title: Text(product.name),
                subtitle: Text(product.price),
                trailing: const Icon(CupertinoIcons.suit_heart),
              )
            ],
          ),
        ),
      ),
    );
  }
}
