import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/Services/repos/authRepo.dart';
import 'package:project1/features/home/presentation/manager/app%20cubit/app_cubit.dart';
import 'package:project1/features/profile/data/models/user%20details%20model/user_details.dart';
import 'widgets/account widgets/account_view_body.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});
  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        return AccountViewBody( 
          user: UserDetailsModel(
              email: AuthApi.currentUser.email,
              name: AuthApi.currentUser.name,
              id: AuthApi.currentUser.id ?? '',
              username: AuthApi.currentUser.name,
              password: AuthApi.currentUser.password),
        );
      },
    );
  }
}
