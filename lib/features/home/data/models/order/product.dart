import 'product_id.dart';

class Product {
  ProductId? productId;
  int? quantity;
  String? id;

  Product({this.productId, this.quantity, this.id});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json['productId'] == null
            ? null
            : ProductId.fromJson(json['productId'] as Map<String, dynamic>),
        quantity: json['quantity'] as int?,
        id: json['_id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'productId': productId?.toJson(),
        'quantity': quantity,
        '_id': id,
      };
}
