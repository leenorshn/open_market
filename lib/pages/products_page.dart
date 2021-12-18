import 'package:flutter/material.dart';
import 'package:open_market/api/product_api.dart';
import 'package:open_market/components/product_list_tile.dart';
import 'package:open_market/model/product.dart';
import 'package:open_market/screen/detail_product.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
        stream: ProductApi().getProduct(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            print("pas de donnee *******");
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Liste vide"),
            );
          }

          print("ready ********");
          return ListView.separated(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 20,
              bottom: 100,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Product product = snapshot.data![index];

              return ProductListTile(
                product: product,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const DetailProduct()));
                },
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                //color: Colors.grey[600],
                height: 1,
              );
            },
          );
        });
  }
}
