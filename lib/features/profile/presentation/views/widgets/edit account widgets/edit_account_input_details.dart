import 'package:flutter/widgets.dart';

import '../../../../../../core/widgets/custom_authentication_textformfield.dart';

class EditAccountInputDetails extends StatefulWidget {
  const EditAccountInputDetails({
    super.key,
    required this.autovalidateMode,
    required this.controller,
    this.enabled,
    required this.lable,
    this.isPassword,
    required nameController,
  });
  final AutovalidateMode autovalidateMode;
  final TextEditingController controller;
  final bool? enabled;
  final bool? isPassword;
  final String lable;
  @override
  State<EditAccountInputDetails> createState() =>
      _EditAccountInputDetailsState();
}

class _EditAccountInputDetailsState extends State<EditAccountInputDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomAuthenticationTextformfield(
          isPassword: widget.isPassword ?? false,
          enabled: widget.enabled,
          autovalidateMode: widget.autovalidateMode,
          controller: widget.controller,
          type: TextInputType.name,
          label: widget.lable,
          validate: (value) {
            if (value?.isEmpty ?? true) {
              return 'Please enter your name';
            } else {
              return null;
            }
          },
        ),
        const SizedBox(
          height: 20,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
