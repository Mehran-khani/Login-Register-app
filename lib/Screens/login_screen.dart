import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLogin) {
          if (state.exception is UserNotFoundAuthExcepion ||
              state.exception is WrongPasswordAuthException) {
            await showErrorDialog(
                context, 'Cannot find a user with entered credentials');
          } else if (state.exception is UserNotLoggedInAuthException) {
            await showErrorDialog(context, 'erro');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Authentication error');
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
                      'Welcome back!',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    CustomTextfield(
                      controller: emailController,
                      hintText: 'Enter your email',
                    ),
                    CustomPassfield(
                        controller: passwordController,
                        hintText: 'Enter your password'),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 46),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (context) => ForgotPasswordScreen(),
                            // ));
                            context.read<AuthBloc>().add(
                                  const AuthEventForgotPassword(),
                                );
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                                color: Color(0xff6A707C),
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    CutsomButtom(
                        text: 'Login',
                        onPressed: () {
                          context.read<AuthBloc>().add(
                                AuthEventLogIn(
                                  emailController.text,
                                  passwordController.text,
                                ),
                              );
                        }),
                    const SizedBox(
                      height: 22,
                    ),
                    const CustomDivider(text: 'Or Login with'),
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
                        const Text('Don’t have an account?'),
                        TextButton(
                          onPressed: () {
                            context
                                .read<AuthBloc>()
                                .add(const AuthEventShouldRegister());
                          },
                          child: const Text('Register Now'),
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
