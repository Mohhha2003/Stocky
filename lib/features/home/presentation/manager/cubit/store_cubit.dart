import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:project1/Services/store_repo.dart';
import 'package:project1/features/authentication/presentation/views/authModel.dart';
import 'package:project1/features/home/data/models/product_model.dart';

part 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  StoreCubit(this.productRepo) : super(StoreInitial()) {
    getProducts();
  }

  final ProductRepo productRepo;
  List<ProductModel> prodcuts = [];
  String categorie = '';
  String gender = '';
  late User appUser;

  void getProducts() async {
    prodcuts.clear();
    emit(StoreLoading());
    try {
      final response = await productRepo.getAllProducts();
      prodcuts.addAll(response);
      if (prodcuts.isEmpty) {
        emit(StoreEmpty());
      } else {
        emit(StoreSuccess());
      }
    } on Exception catch (e) {
      emit(StoreFailed());
    }
  }

  void getPorductCategorie() async {
    print('Goning in the cubit');
    prodcuts.clear();
    emit(StoreLoading());
    try {
      final response = await productRepo.getProductWithCateogire(
          categorie: categorie, gender: gender);
      prodcuts.addAll(response);
      if (prodcuts.isEmpty) {
        emit(StoreEmpty());
      } else {
        emit(StoreSuccess());
      }
    } on Exception catch (e) {
      emit(StoreFailed());
    }
  }
}
