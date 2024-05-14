import 'package:dio/dio.dart';
import 'package:project1/core/utils/api_constant.dart';

class CartRepo {
  late Dio dio;

  CartRepo() {
    dio = Dio();
  }

  getUserCartProduct({required String owenerId}) async {
    try {
      Response response = await dio.get(
        '${ApiConstant.basseUrl}${ApiConstant.cart}/$owenerId',
      );
      if (response.data != null) {}
      print(response.data);
    } on Exception catch (e) {
      print('The error is $e');
    }
  }

  addToCart() async {
    try {} catch (e) {}
  }
}
