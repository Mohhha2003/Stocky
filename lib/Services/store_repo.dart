import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
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

  Future<void> addProduct({
    required String name,
    required String description,
    required String category,
    required String gender,
    required double price,
    required String ownerId,
    required File image,
  }) async {
    try {
      String fileName = image.path.split('/').last;
      if (!fileName.toLowerCase().endsWith('.jpg') &&
          !fileName.toLowerCase().endsWith('.png') &&
          !fileName.toLowerCase().endsWith('.jpeg')) {
         
        return;
      }

      // Create FormData object
      FormData formData = FormData.fromMap({
        'name': name,
        'description': description,
        'category': category,
        'gender': gender,
        'price': price,
        'ownerId': ownerId,
        'image': await MultipartFile.fromFile(
          image.path,
          filename: fileName, // Use the original file name
        ),
      });

      // Send request using Dio
      Response response = await dio.post(
        '${ApiConstant.basseUrl}${ApiConstant.addProduct}',
        data: formData,
      );

      // Handle response
      if (response.statusCode == 200) {
        print('Product added: ${response.data}');
      } else {
        print('Failed to add product: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<File?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      print('No image selected.');
      return null;
    }
  }
}
