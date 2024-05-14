import 'package:dio/dio.dart';
import 'package:project1/core/utils/api_constant.dart';
import 'package:project1/features/home/data/models/product_model.dart';

class Fav {
  late Dio dio;

  Fav() {
    dio = Dio();
  }

  Future<bool> addToFavorite({required ProductModel product}) async {
    try {
      Response response = await dio.post(
          '${ApiConstant.basseUrl}${ApiConstant.favourite}',
          data: product.toJson());
      print(response.data);
      return true;
    } on Exception catch (e) {
      print('The error in fav is $e');
      return false;
    }
  }

  Future<List<ProductModel>> getUserFavourites(
      {required String ownerId}) async {
    try {
      Response response = await dio.get(
        '${ApiConstant.basseUrl}${ApiConstant.favourite}',
        queryParameters: {"ownerId": ownerId},
      );

      List<ProductModel> products = [];

      if (response.data != null && response.data is List) {
        products = List<ProductModel>.from(
          (response.data as List)
              .map((e) => ProductModel.fromJson(e as Map<String, dynamic>)),
        );
      }

      print('This is the fav ${response.data}');
      return products;
    } on Exception catch (e) {
      print('The error is $e');
      return <ProductModel>[];
    }
  }
}
