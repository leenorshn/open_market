class Product {
  late int id;
  late String name;
  late String price;
  late String imgUrl;
  late String description;

  Product(
      {required this.id,
      required this.name,
      required this.price,
      required this.imgUrl,
      required this.description});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    imgUrl = json['imgUrl'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['imgUrl'] = imgUrl;
    data['description'] = description;
    return data;
  }
}
