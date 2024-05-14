import 'package:dio/dio.dart';
import 'package:project1/core/utils/api_constant.dart';
import 'package:project1/features/home/data/models/product_model.dart';

class Fav {
  late Dio dio;

  Fav() {
    dio = Dio();
  }

  Future<List<ProductModel>> addToFavorite(
      {required ProductModel product}) async {
    try {
      Response response = await dio.post(
          '${ApiConstant.basseUrl}${ApiConstant.favourite}',
          data: product.toJson());
      List<ProductModel> products = [];
      if (response.data != null) {
        products = List<ProductModel>.from(
          response.data.map((e) => ProductModel.fromJson(e)),
        );
      }
      print(products.length);
      return products;
    } on Exception catch (e) {
      print('The error in fav is $e');
      return <ProductModel>[];
    }
  }

  Future<List<ProductModel>> getUserFavourites(
      {required String ownerId}) async {
    try {
      Response response = await dio.get(
          '${ApiConstant.basseUrl}${ApiConstant.favourite}',
          data: {"ownerId": '66436148997939ee89ee912f'});
      List<ProductModel> products = [];
      if (response.data != null) {
        products = List<ProductModel>.from(
          response.data.map((e) => ProductModel.fromJson(e)),
        );
      }
      print(products.length);
      return products;
    } on Exception catch (e) {
      print('The error is $e');
      return <ProductModel>[];
    }
  }
}
