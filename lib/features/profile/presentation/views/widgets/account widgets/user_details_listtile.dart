import 'package:flutter/material.dart';
import 'package:project1/core/widgets/app_colors.dart';
import 'package:project1/features/profile/presentation/views/widgets/cached_profile_network_image.dart';
import '../../../../data/models/user details model/user_details.dart';
import 'user_name.dart';

class UserDetailsListTile extends StatelessWidget {
  const UserDetailsListTile({
    super.key,
    required this.user,
  });
  final UserDetailsModel user;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 114,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(27),
          child: cachedProfilNetworkImage(
              imageUrl: user.email, height: 64, width: 64),
        ),
        title: CustomUserName (
          user: user,
        ),
        subtitle: Text(
          user.email,
          style: const TextStyle(
              fontSize: 16, color: Color(AppColors.kPrimaryColor)),
        ),
      ),
    );
  }
}
