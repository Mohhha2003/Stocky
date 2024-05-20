class ProductModel {
  late final String image;
  late final String name;
  late final String category;
  late final String description;
  late final int price;
  late final String gender;
  late final String ownerId;
  late final String id;
  final int? quantity;

  ProductModel(
      {required this.image,
      this.quantity,
      required this.id,
      required this.name,
      required this.category,
      required this.description,
      required this.price,
      required this.gender,
      required this.ownerId});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['_id'],
        image: json['image'].toString().replaceFirst('10.0.2.2', '192.168.1.6'),
        name: json['name'],
        category: json['category'],
        description: json['description'],
        price: json['price'],
        gender: json['gender'],
        ownerId: json['ownerId'],
      );

  static List<ProductModel> fromJsonList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((json) => ProductModel.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = id;
    data['image'] = image;
    data['name'] = name;
    data['category'] = category;
    data['description'] = description;
    data['price'] = price;
    data['gender'] = gender;
    // data['ownerId'] = ownerId;
    return data;
  }
}
