import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../Services/repos/authRepo.dart';
import '../../../../../../core/utils/app_routes.dart';
import '../../../../../../core/widgets/app_colors.dart';
import '../../../../../../core/widgets/custom_my_button.dart';
import '../../../../../../core/widgets/custom_text_form_feild.dart';
import '../build_rich_text.dart';
import '../build_text_next_to_text_button.dart';
import '../build_two_text_form_field.dart';
import 'custom_forget_password.dart';

class LoginScreenBody extends StatefulWidget {
  const LoginScreenBody({Key? key});

  @override
  State<LoginScreenBody> createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passController;

  @override
  void initState() {
    emailController = TextEditingController();
    passController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
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
                      textPartOne: 'Log ',
                      textPartTwo: 'In',
                    ),
                    const Gap(30),
                    CustomTwoTextFromField(
                      controller1: emailController,
                      controller2: passController,
                      label1: 'Email',
                      label2: 'Password',
                      isPass: false,
                      isPass2: true,
                    ),
                    const Gap(10),
                    CustomForgetPassword(
                      onTap: () {},
                    ),
                    const Gap(40),
                    CustomButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          final email = emailController.text;
                          final password = passController.text;
                          try {
                            final user = await AuthApi().loginUser(
                              email: email,
                              password: password,
                            );
                            print('User logged in: ${user.email}');
                            GoRouter.of(context)
                                .pushReplacement(AppRoutes.homeView);
                          } catch (e) {
                            print('Error logging in: $e');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Failed to login. Please try again.'),
                              ),
                            );
                          }
                        }
                      },
                      text: 'Login',
                      height: 42,
                      color: AppColors.kPrimaryColor,
                      width: MediaQuery.of(context).size.width,
                      horizontal: 0,
                      vertical: 0,
                      radius: 10,
                      textColor: AppColors.kWhiteColor,
                      fontSize: 20,
                    ),
                    const Gap(10),
                    customTextNextToTextButton(
                      context: context,
                      text: 'Don\'t have an account ?',
                      textButton: 'Create Account',
                      onPressed: () {
                        GoRouter.of(context)
                            .pushReplacement(AppRoutes.registerView);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
