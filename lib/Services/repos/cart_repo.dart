import 'package:dio/dio.dart';
import 'package:project1/core/utils/api_constant.dart';
import 'package:project1/features/home/data/models/cart/cart_model.dart';
import 'package:project1/features/home/data/models/product_model.dart';

import 'authRepo.dart';

class CartRepo {
  late Dio dio;

  CartRepo() {
    dio = Dio();
  }

  Future<List<CartModel>> getUserCartProduct({required String ownerId}) async {
    try {
      Response response = await dio.get(
        '${ApiConstant.basseUrl}${ApiConstant.cart}/$ownerId',
      );

      List<CartModel> products = [];

      if (response.data != null && response.data is List) {
        products = List<CartModel>.from(
          (response.data as List)
              .map((e) => CartModel.fromJson(e as Map<String, dynamic>)),
        );
      }
      print('This is the fav ${response.data}');
      return products;
    } on Exception catch (e) {
      print('The error is $e');
      return <CartModel>[];
    }
  }

  addToCart({required ProductModel product}) async {
    Map<String, dynamic> productMap = product.toJson();
    productMap['ownerId'] = AuthApi.currentUser.id!;
    try {
      Response response = await dio
          .post('${ApiConstant.basseUrl}${ApiConstant.cart}', data: productMap);
      return true;
    } on DioException catch (e) {
      print('The error in fav is $e');
      throw Exception(e.message);
    }
  }

  

  Future<bool> deleteFavourite({required CartModel product}) async {
    print('Joined the delete');
    try {
      Response response = await dio.delete(
          '${ApiConstant.basseUrl}${ApiConstant.cart}',
          data: product.toJson());
      print(response.data);
      return true;
    } on DioException catch (e) {
      print('The error in fav is $e');
      throw Exception(e.message);
    }
  }
}
