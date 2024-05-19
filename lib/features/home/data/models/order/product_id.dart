class ProductId {
  String? id;
  String? name;
  String? description;
  String? category;
  String? gender;
  int? price;
  String? ownerId;
  String? image;
  int? v;

  ProductId({
    this.id,
    this.name,
    this.description,
    this.category,
    this.gender,
    this.price,
    this.ownerId,
    this.image,
    this.v,
  });

  factory ProductId.fromJson(Map<String, dynamic> json) => ProductId(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        category: json['category'] as String?,
        gender: json['gender'] as String?,
        price: json['price'] as int?,
        ownerId: json['ownerId'] as String?,
        image: json['image'] as String?,
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'description': description,
        'category': category,
        'gender': gender,
        'price': price,
        'ownerId': ownerId,
        'image': image,
        '__v': v,
      };
}
