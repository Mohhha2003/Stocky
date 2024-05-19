import 'product.dart';

class Order {
  String? id;
  List<Product>? products;
  String? userId;
  int? totalPrice;
  String? status;
  DateTime? orderDate;
  int? v;

  Order({
    this.id,
    this.products,
    this.userId,
    this.totalPrice,
    this.status,
    this.orderDate,
    this.v,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json['_id'] as String?,
        products: (json['products'] as List<dynamic>?)
            ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
            .toList(),
        userId: json['userId'] as String?,
        totalPrice: json['totalPrice'] as int?,
        status: json['status'] as String?,
        orderDate: json['orderDate'] == null
            ? null
            : DateTime.parse(json['orderDate'] as String),
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'products': products?.map((e) => e.toJson()).toList(),
        'userId': userId,
        'totalPrice': totalPrice,
        'status': status,
        'orderDate': orderDate?.toIso8601String(),
        '__v': v,
      };
}
