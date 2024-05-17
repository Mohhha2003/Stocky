import 'package:flutter/material.dart';
import 'package:project1/Services/repos/authRepo.dart';
import '../../data/models/user details model/user_details.dart';
import 'widgets/edit account widgets/edit_account_view_body.dart';

class EditAccountView extends StatelessWidget {
  const EditAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EditAccountViewBody(
        user: UserDetailsModel(
          email: AuthApi.currentUser.email,
          name: AuthApi.currentUser.name,
          username: AuthApi.currentUser.name,
          password: AuthApi.currentUser.password ?? '',
          id: AuthApi.currentUser.id ?? 'NO id',
        ),
      ),
    );
  }
}
