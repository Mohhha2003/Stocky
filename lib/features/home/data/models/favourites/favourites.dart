import 'package:project1/Services/repos/authRepo.dart';
import 'package:project1/features/home/data/models/product_model.dart';

class Favourites {
  String? id;
  String? productId;
  String? ownerId;
  String? name;
  int? price;
  int? v;

  Favourites({
    this.id,
    this.productId,
    this.ownerId,
    this.name,
    this.price,
    this.v,
  });

  factory Favourites.fromJson(Map<String, dynamic> json) => Favourites(
        id: json['_id'] as String?,
        productId: json['productId'] as String?,
        ownerId: json['ownerId'] as String?,
        name: json['name'] as String?,
        price: json['price'] as int?,
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'productId': productId,
        'ownerId': ownerId,
        'name': name,
        'price': price,
        '__v': v,
      };

  Favourites fromProductModelToFavouritesModel(
          {required ProductModel productModel}) =>
      Favourites(
          name: productModel.name,
          ownerId: AuthApi.currentUser.id,
          productId: productModel.id,
          price: productModel.price,
          id: productModel.id);
}
