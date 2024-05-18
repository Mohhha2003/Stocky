import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project1/Services/repos/user_repo.dart';
import 'package:project1/features/authentication/presentation/views/authModel.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  late User appUser;

  updateUser({required User user}) async {
    try {
      await UserRepo().updateProfile(user: user);
      emit(UserUpdated());
    } on Exception catch (e) {
      emit(UserFailed());
    }
  }
}
