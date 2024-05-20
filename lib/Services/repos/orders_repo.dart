import 'package:dio/dio.dart';
import 'package:project1/Services/repos/authRepo.dart';
import 'package:project1/core/utils/api_constant.dart';
import 'package:project1/features/home/data/models/cart/cart_model.dart';
import 'package:project1/features/home/data/models/order/order.dart';

class OrdresRepo {
  late Dio dio;

  OrdresRepo() {
    dio = Dio();
  }

  Future<void> placeOrder({required List<CartModel> products}) async {
    try {
      final response =
          await dio.post('${ApiConstant.basseUrl}${ApiConstant.orders}', data: {
        "userId": AuthApi.currentUser.id ?? '',
        "products": products.map((product) => product.toJson()).toList()
      });
    } on DioException catch (e) {
      throw Exception(e.error);
    }
  }

  Future<List<Order>> getUserId() async {
    print('in the method');
    try {
      final response = await dio.get(
          '${ApiConstant.basseUrl}${ApiConstant.userOrders}',
          data: {"userId": AuthApi.currentUser.id ?? ''});
      List<Order> orders = [];
      List data = response.data['orders'];
      print('The resposne is ${response.data}');
      for (var order in data) {
        orders.add(Order.fromJson(order));
      }
      print(' The ORders list is ${orders.length}');
      return orders;
    } on DioException catch (e) {
      throw Exception(e.error);
    }
  }
}
