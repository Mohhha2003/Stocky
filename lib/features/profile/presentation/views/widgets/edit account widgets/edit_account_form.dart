import 'package:flutter/widgets.dart';
import '../../../../data/models/user details model/user_details.dart';
import 'edit_account_input_details.dart';

class EditAccountForm extends StatefulWidget {
  const EditAccountForm({
    super.key,
    required this.user,
    required this.nameController,
    required this.emailController,
    required this.passwordController, required this.formkey,
  });
  final UserDetailsModel user;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey formkey;

  @override
  State<EditAccountForm> createState() => _EditAccountFormState();
}

class _EditAccountFormState extends State<EditAccountForm> {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          EditAccountInputDetails(
            autovalidateMode: autovalidateMode,
            controller: widget.nameController,
            lable: 'name',
            nameController: null,
          ),
          EditAccountInputDetails(
            enabled: false,
            autovalidateMode: autovalidateMode,
            controller: widget.emailController,
            lable: 'E-mail',
            nameController: null,
          ),
          EditAccountInputDetails(
            autovalidateMode: autovalidateMode,
            controller: widget.passwordController,
            lable: 'Password',
            nameController: null,
          ),
          // EditAccountInputDetails(
          //   autovalidateMode: autovalidateMode,
          //   nameController: widget.nameController,
          // ),
          // EditAccountInputDetails(
          //   autovalidateMode: autovalidateMode,
          //   nameController: widget.nameController,
          // ),
        ],
      ),
    );
  }
}
