import 'package:project1/features/home/data/models/product_model.dart';

class UserDetailsModel {
  final String username;
  final String name;
  final String email;
  final String password;
  List<ProductModel>?fav;

  UserDetailsModel({
    required this.username,
    required this.name,
    required this.email,
    required this.password,
    required String id,
    this.fav
  });

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) {
    return UserDetailsModel(
      username: json['username'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      id: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
