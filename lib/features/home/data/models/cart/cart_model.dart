class CartModel {
  String? id;
  String? ownerId;
  String? productId;
  String? name;
  int? price;
  int? quantity;
  int? v;

  CartModel({
    this.id,
    this.ownerId,
    this.productId,
    this.name,
    this.price,
    this.quantity,
    this.v,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json['_id'] as String?,
        ownerId: json['ownerId'] as String?,
        productId: json['productId'] as String?,
        name: json['name'] as String?,
        price: json['price'] as int?,
        quantity: json['quantity'] as int?,
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'ownerId': ownerId,
        'productId': productId,
        'name': name,
        'price': price,
        'quantity': quantity,
        '__v': v,
      };
}
