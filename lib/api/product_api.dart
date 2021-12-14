import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:open_market/model/product.dart';

class ProductApi {
  Future<List<Product>> getProduct() async {
    var data = await rootBundle.loadString('data/data.json');
    var t = [];
    t = json.decode(data);
    //print(t[0]);

    return t.map((e) => Product.fromJson(e)).toList();
  }
}
