import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:project1/Services/repos/authRepo.dart';
import '../../authModel.dart';
import '../../../../../../core/utils/app_routes.dart';
import '../../../../../../core/widgets/app_colors.dart';
import '../../../../../../core/widgets/custom_my_button.dart';
import '../../../../../../core/widgets/custom_text_form_feild.dart';
import '../build_rich_text.dart';
import '../build_text_next_to_text_button.dart';
import '../build_two_text_form_field.dart';

class RegisterScreenBody extends StatefulWidget {
  const RegisterScreenBody({Key? key});

  @override
  State<RegisterScreenBody> createState() => _RegisterScreenBodyState();
}

class _RegisterScreenBodyState extends State<RegisterScreenBody> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passController;
  late TextEditingController nameController;

  @override
  void initState() {
    emailController = TextEditingController();
    passController = TextEditingController();
    nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    nameController.dispose();
    super.dispose();
  }

  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomRichText(
                    textPartOne: 'Sign ',
                    textPartTwo: 'Up',
                  ),
                  const Gap(30),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(AppColors.kLoginWithGoogleColor),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: CustomTextFormField(
                      isPassword: false,
                      maxLine: 1,
                      prefixIcon: IconlyBroken.profile,
                      controller: nameController,
                      border: InputBorder.none,
                      label: 'username',
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a username';
                        }
                        return null;
                      },
                    ),
                  ),
                  const Gap(20),
                  CustomTwoTextFromField(
                    controller1: emailController,
                    controller2: passController,
                    label1: 'Email',
                    label2: 'Password',
                    isPass: false,
                    isPass2: true,
                    prefixIcon1: IconlyBroken.message,
                    prefixIcon2: IconlyBroken.lock,
                  ),
                  const Gap(30),
                  const Gap(20),
                  CustomButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        final user = User(
                          name: nameController.text,
                          email: emailController.text,
                          password: passController.text,
                          image: 'afjdslkf',
                        );
                        await AuthApi().registerUser(user: user);

                        print('User registered: ${user.email}');
                        GoRouter.of(context)
                            .pushReplacement(AppRoutes.homeView);
                      }
                    },
                    text: 'Sign Up',
                    height: 42,
                    color: AppColors.kPrimaryColor,
                    width: MediaQuery.of(context).size.width,
                    horizontal: 0,
                    vertical: 0,
                    radius: 10,
                    textColor: AppColors.kWhiteColor,
                    fontSize: 20,
                  ),
                  const Gap(30),
                  customTextNextToTextButton(
                    context: context,
                    text: 'Already have an account?',
                    textButton: 'Login',
                    onPressed: () async {
                      GoRouter.of(context).pushReplacement(AppRoutes.loginView);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
