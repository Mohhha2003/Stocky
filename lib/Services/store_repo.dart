import 'package:dio/dio.dart';
import 'package:project1/core/utils/api_constant.dart';
import 'package:project1/features/home/data/models/product_model.dart';

class ProductRepo {
  late Dio dio;

  ProductRepo() {
    dio = Dio();
  }

  Future<List<ProductModel>> getAllProducts() async {
    try {
      Response response = await dio.get('${ApiConstant.basseUrl}/api/products');
      List<ProductModel> products = [];

      if (response.data != null) {
        products = List<ProductModel>.from(
          response.data.map((e) => ProductModel.fromJson(e)),
        );
      }
      return products;
    } catch (e) {
      return <ProductModel>[];
    }
  }

  Future<List<ProductModel>> getProductWithCateogire(
      {required String categorie, required String gender}) async {
    try {
      final response = await dio.get(
          '${ApiConstant.basseUrl}${ApiConstant.catgorie}',
          data: {"gender": gender, "category": categorie});
      return List<ProductModel>.from(
        response.data.map((e) => ProductModel.fromJson(e)),
      );
    } on DioException catch (e) {
      throw Exception(e.error);
    }
  }

  Future<List<ProductModel>> saerchProducts({required String keyword}) async {
    try {
      final response = await dio.get(
          '${ApiConstant.basseUrl}${ApiConstant.search}',
          data: {"keyword": keyword});
      print(response.data);
      return List<ProductModel>.from(
          response.data.map((e) => ProductModel.fromJson(e)));
    } on DioException catch (e) {
      throw Exception(e.error);
    }
  }
}
