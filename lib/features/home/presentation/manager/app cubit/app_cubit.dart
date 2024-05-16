import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/features/home/presentation/views/cart.dart';
import 'package:project1/features/home/presentation/views/fav_screen.dart';
import 'package:project1/features/home/presentation/views/home.dart';
import 'package:project1/features/profile/presentation/views/account_view.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  void changeNav(int index) {
    currentIndex = index;
    emit(ChangeNavBarState());
  }

  List<Widget> screen = const [
    HomeScreen(),
    CartScreen(),
    FavScreen(),
    AccountView()
  ];
}
