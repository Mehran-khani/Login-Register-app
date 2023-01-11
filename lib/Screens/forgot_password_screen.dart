import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_register_app/auth/bloc/auth_bloc.dart';
import 'package:login_register_app/auth/bloc/auth_event.dart';
import 'package:login_register_app/auth/bloc/auth_state.dart';
import 'package:login_register_app/widgets/custom_button.dart';
import 'package:login_register_app/widgets/custom_text_field.dart';
import 'package:login_register_app/widgets/dialouge/error_dialog.dart';
import 'package:login_register_app/widgets/dialouge/password_reset_email_sent_dialog.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateFotgotPassword) {
          if (state.hasSentEmail) {
            emailController.clear();
            await showPasswordResetSentDialog(context);
          }
          if (state.exception != null) {
            await showErrorDialog(context,
                'We could not process request. Please make sure that you are a registered user.');
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
                    Navigator.of(context).pop();
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
                      'Forgot Password?',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 46, right: 46),
                      child: Text(
                        'Dont worry! It occurs. Please enter the email address linked with your account.',
                        style: TextStyle(color: Color(0xff8391A1)),
                      ),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    CustomTextfield(
                      controller: emailController,
                      hintText: 'Enter your email',
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    CutsomButtom(
                        text: 'Submit',
                        onPressed: () {
                          context.read<AuthBloc>().add(AuthEventForgotPassword(
                              email: emailController.text));
                        }),
                    const SizedBox(
                      height: 22,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Remember Password?'),
                        TextButton(
                          onPressed: () {
                            context
                                .read<AuthBloc>()
                                .add(const AuthEventLogOut());
                          },
                          child: const Text('Login'),
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
