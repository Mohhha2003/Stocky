import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project1/Services/store_repo.dart';
import 'package:project1/features/home/data/models/product_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  List<ProductModel> search = [];

  void searchProducts({required String keyword}) async {
    search.clear();
    emit(SearchLoading());
    try {
      search = await ProductRepo().saerchProducts(keyword: keyword);
      if (search.isEmpty) {
        return emit(SearchEmpty());
      }
      emit(SearchSuccess());
    } on Exception catch (e) {
      emit(SearchFailed());
    }
  }
}
