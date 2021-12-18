class Contact {
  late String phone;
  late String name;
  late String avatar;

  Contact({required this.phone, required this.name, required this.avatar});

  Contact.fromJson(var json) {
    phone = json['phone'];
    name = json['name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['phone'] = phone;
    data['name'] = name;
    data['avatar'] = avatar;
    return data;
  }
}
