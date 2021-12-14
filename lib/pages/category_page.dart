import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_market/api/product_api.dart';
import 'package:open_market/components/product_grid_tile.dart';
import 'package:open_market/model/product.dart';
import 'package:open_market/screen/detail_product.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
        stream: ProductApi().getProduct().asStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return GridView.builder(
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 24, bottom: 100),
            itemCount: snapshot.data!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 7 / 9,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8),
            itemBuilder: (context, index) {
              return ProductGridTile(
                product: snapshot.data![index],
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const DetailProduct()));
                },
              );
            },
          );
        });
  }
}
