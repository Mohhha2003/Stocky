import 'package:dio/dio.dart';
import 'package:project1/core/utils/api_constant.dart';
import 'package:project1/features/authentication/presentation/views/authModel.dart';

class UserRepo {
  late Dio dio;

  UserRepo() {
    dio = Dio();
  }

  Future<User> updateProfile({required User user}) async {
    print('the user is ${user.toJson()}');
    try {
      final response = await dio.put(
          "${ApiConstant.basseUrl}${ApiConstant.updateProfile}",
          data: user.toJson());

      return User.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.error);
    }
  }
}
