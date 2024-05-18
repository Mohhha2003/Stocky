import 'package:dio/dio.dart';
import 'package:project1/Services/repos/authRepo.dart';
import 'package:project1/core/utils/api_constant.dart';
import 'package:project1/features/home/data/models/favourites/favourites.dart';
import 'package:project1/features/home/data/models/product_model.dart';

class Fav {
  late Dio dio;

  Fav() {
    dio = Dio();
  }

  Future<bool> addToFavorite({required ProductModel product}) async {
    Map<String, dynamic> productMap = product.toJson();
    productMap['ownerId'] = AuthApi.currentUser.id ?? "";
    try {
      Response response = await dio.post(
          '${ApiConstant.basseUrl}${ApiConstant.favourite}',
          data: productMap);

      return true;
    } on DioException catch (e) {
      print('The error in fav is $e');
      throw Exception(e.message);
    }
  }

  Future<List<Favourites>> getUserFavourites({required String ownerId}) async {
    try {
      Response response = await dio.get(
        '${ApiConstant.basseUrl}${ApiConstant.favourite}',
        queryParameters: {"ownerId": ownerId},
      );

      List<Favourites> products = [];

      if (response.data != null && response.data is List) {
        products = List<Favourites>.from(
          (response.data as List)
              .map((e) => Favourites.fromJson(e as Map<String, dynamic>)),
        );
      }

      print('This is the fav ${response.data}');
      return products;
    } on Exception catch (e) {
      print('The error is $e');
      return <Favourites>[];
    }
  }

  Future<bool> deleteFavourite({required Favourites product}) async {
    print('Joined the delete');
    try {
      Response response = await dio.delete(
          '${ApiConstant.basseUrl}${ApiConstant.favourite}',
          data: product.toJson());
      return true;
    } on DioException catch (e) {
      print('The error in fav is $e');
      throw Exception(e.message);
    }
  }
}
