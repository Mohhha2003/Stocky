import 'package:dio/dio.dart';
import 'package:project1/core/utils/api_constant.dart';
import '../../features/authentication/presentation/views/authModel.dart';

class AuthApi {
  late Dio dio;

  AuthApi() {
    dio = Dio();
  }

  Future<User> registerUser({required User user}) async {
    try {
      Response response = await dio.post(
        '${ApiConstant.basseUrl}${ApiConstant.register}',
        data: user.toJson(),
      );
      return User.fromJson(response.data);
    } catch (e) {
      print('Error registering user: $e');
      throw Exception('Failed to register user');
    }
  }

  Future<User> loginUser({required String email, required String password}) async {
    try {
      Response response = await dio.post(
        '${ApiConstant.basseUrl}${ApiConstant.login}',
        data: {'email': email, 'password': password},
      );
      return User.fromJson(response.data);
    } catch (e) {
      print('Error logging in user: $e');
      throw Exception('Failed to login user');
    }
  }

}
