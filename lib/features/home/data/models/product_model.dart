class ProductModel {
  late final String image;
  late final String name;
  late final String category;
  late final String description;
  late final int price;
  late final String gender;
  late final String ownerId;

  ProductModel({
    required this.image,
    required this.name,
    required this.category,
    required this.description,
    required this.price ,
    required this.gender,
    required this.ownerId
  });

   factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(image: json['image'], name: json['name'], category: json['category'], description: json['description'], price: json['price'], gender: json['gender'], ownerId: json['ownerId']);


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['name'] = name;
    data['category'] = category;
    data['description'] = description;
    data['price'] = price;
    data['gender'] = gender;
    data['ownerId'] = ownerId;
    return data;
  }
}
