import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:project1/Services/repos/authRepo.dart';
import 'package:project1/Services/repos/user_repo.dart';
import 'package:project1/core/utils/show_snack_bar.dart';
import 'package:project1/features/authentication/presentation/views/authModel.dart';
import 'package:project1/features/home/presentation/views/home_page.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../data/models/user details model/user_details.dart';
import 'custom_add_image.dart';
import 'edit_account_appbar.dart';
import 'edit_account_form.dart';

class EditAccountViewBody extends StatefulWidget {
  const EditAccountViewBody({super.key, required this.user});
  final UserDetailsModel user;

  @override
  State<EditAccountViewBody> createState() => _EditAccountViewBodyState();
}

class _EditAccountViewBodyState extends State<EditAccountViewBody> {
  late String newName;
  late String newPhotoUrl;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late GlobalKey<FormState> formkey;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.user.name);
    emailController = TextEditingController(text: widget.user.email);
    passwordController = TextEditingController(text: widget.user.password);
    formkey = GlobalKey();

    newName = nameController.text;
    newPhotoUrl = widget.user.email;
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            const EditAccountAppbar(),
            const Gap(40),
            CustomAddImage(
              imageUrl: widget.user.email ?? '',
              onPressed: () {},
            ),
            const Gap(
              20,
            ),
            EditAccountForm(
              formkey: formkey,
              passwordController: passwordController,
              emailController: emailController,
              user: widget.user,
              nameController: nameController,
            ),
            const Gap(60),
            AnimatedOpacity(
              opacity: 1,
              duration: const Duration(milliseconds: 300),
              child: CustomActionButton(
                  buttonText: 'Update',
                  onTap: () async {
                    try {
                      AuthApi.currentUser = await UserRepo().updateProfile(
                          user: User(
                              id: AuthApi.currentUser.id,
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text));

                      Navigator.of(context).pop();
                    } on Exception catch (e) {
                      showSnackBar(text: 'Error Updating', context: context);
                    }
                  }),
            ),
            const Gap(20)
          ],
        ),
      ),
    );
  }
}
