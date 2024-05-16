import 'package:dio/dio.dart';
import 'package:project1/Services/repos/fav_repo.dart';
import 'package:project1/core/utils/api_constant.dart';
import 'package:project1/core/utils/show_snack_bar.dart';
import '../../features/authentication/presentation/views/authModel.dart';

class AuthApi {
  late Dio dio;

  static late User currentUser;

  AuthApi() {
    dio = Dio();
  }

  Future<User> registerUser({required User user}) async {
    try {
      Response response = await dio.post(
        '${ApiConstant.basseUrl}${ApiConstant.register}',
        data: user.toJson(),
      );
      return User.fromJson(response.data['data']);
    } catch (e) {
      print('Error registering user: $e');
      throw Exception('Failed to register user');
    }
  }

  Future<User> loginUser(
      {required String email, required String password}) async {
    print('Joined logging in ');
    try {
      Response response = await dio.post(
        '${ApiConstant.basseUrl}${ApiConstant.login}',
        data: {'email': email, 'password': password},
      );
      User nowUser = User.fromJson(response.data['data']);
      print('The user id is ${nowUser.id}');
      await Fav().getUserFavourites(ownerId: nowUser.id ?? 'null');
      currentUser = nowUser;
      return nowUser;
    } catch (e) {
      print('Error logging in user: $e');
      throw Exception('Failed to login user');
    }
  }
}
