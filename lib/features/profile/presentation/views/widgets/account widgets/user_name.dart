import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project1/Services/repos/authRepo.dart';
import '../../../../../../core/utils/app_routes.dart';
import '../../../../../../core/widgets/app_colors.dart';
import '../../../../data/models/user details model/user_details.dart';

class CustomUserName extends StatelessWidget {
  const CustomUserName({
    super.key,
    required this.user,
  });
  final UserDetailsModel user;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          user.name,
          style: const TextStyle(
              fontSize: 20, color: Color(AppColors.kPrimaryColor)),
        ),
                  AuthApi.currentUser.id != null ?

        IconButton(
          onPressed: () {
            GoRouter.of(context).push(AppRoutes.editAccountView);
          },
          icon: const Icon(
            Icons.mode_edit_outlined,
            size: 15,
            color: Color(AppColors.kPrimaryColor),
          ),
        ) : const SizedBox(),
      ],
    );
  }
}
