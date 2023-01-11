import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login_register_app/auth/aut_exception.dart';
import 'package:login_register_app/auth/bloc/auth_bloc.dart';
import 'package:login_register_app/auth/bloc/auth_event.dart';
import 'package:login_register_app/auth/bloc/auth_state.dart';
import 'package:login_register_app/widgets/custom_button.dart';
import 'package:login_register_app/widgets/custom_divider.dart';
import 'package:login_register_app/widgets/custom_password_field.dart';
import 'package:login_register_app/widgets/custom_text_field.dart';
import 'package:login_register_app/widgets/dialouge/error_dialog.dart';
import 'package:login_register_app/widgets/social_icons.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController usernameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController cofirmPasswordController;

  @override
  void initState() {
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    cofirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    cofirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateRegistering) {
          if (state.exception is WeakPasswordAuthException) {
            await showErrorDialog(context, 'Weak password');
          } else if (state.exception is EmailAlreadyInUseAuthException) {
            await showErrorDialog(context, 'Email already in use');
          } else if (state.exception is UserNotFoundAuthExcepion) {
            await showErrorDialog(context, 'User Not Found');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Failed to register');
          } else if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(context, 'Invalid email');
          }
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
            child: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: InkWell(
                  child: Image.asset(
                    'assets/icons/back.png',
                    width: 41,
                    height: 41,
                  ),
                  onTap: () {
                    context.read<AuthBloc>().add(const AuthEventLogOut());
                  },
                ),
              ),
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: 200,
                      height: 180,
                    ),
                    const Text(
                      'Hello! Register to get started',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 33,
                    ),
                    CustomTextfield(
                        controller: usernameController,
                        // onChanged: (value) {},
                        hintText: 'Username'),
                    CustomTextfield(
                      controller: emailController,
                      hintText: 'Email',
                    ),
                    CustomPassfield(
                        controller: passwordController, hintText: 'Password'),
                    CustomPassfield(
                        controller: cofirmPasswordController,
                        // onChanged: (value) {},
                        hintText: 'Confirm password'),
                    const SizedBox(
                      height: 50,
                    ),
                    CutsomButtom(
                        text: 'Register',
                        onPressed: () async {
                          if (passwordController.text ==
                              cofirmPasswordController.text) {
                            context.read<AuthBloc>().add(AuthEventRegister(
                                  emailController.text,
                                  passwordController.text,
                                ));
                          } else if (passwordController.text !=
                              cofirmPasswordController.text) {
                            await showErrorDialog(context,
                                'Please check if your passwords are the same');
                          }
                        }),
                    const SizedBox(
                      height: 22,
                    ),
                    const CustomDivider(text: 'Or Register with'),
                    const SizedBox(
                      height: 22,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SocialIcons(
                            onTap: () {},
                            child: SvgPicture.asset(
                                'assets/icons/facebook_ic.svg')),
                        SocialIcons(
                            onTap: () {},
                            child: SvgPicture.asset(
                                'assets/icons/facebook_ic.svg')),
                        SocialIcons(
                            onTap: () {},
                            child:
                                SvgPicture.asset('assets/icons/google_ic.svg'))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        TextButton(
                          onPressed: () {
                            context
                                .read<AuthBloc>()
                                .add(const AuthEventShouldLogin());
                          },
                          child: const Text('Login Now'),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
