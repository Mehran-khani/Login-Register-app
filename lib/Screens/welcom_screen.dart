import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_register_app/Screens/login_screen.dart';
import 'package:login_register_app/auth/bloc/auth_bloc.dart';
import 'package:login_register_app/auth/bloc/auth_event.dart';
import 'package:login_register_app/widgets/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/animation_500_lcc4yyo3.gif'),
            const SizedBox(
              height: 18,
            ),
            Image.asset(
              'assets/images/logo.png',
              width: 200,
              height: 180,
            ),
            CutsomButtom(
                text: 'Login',
                onPressed: () {
                  context.read<AuthBloc>().add(const AuthEventShouldLogin());
                }),
            const SizedBox(
              height: 18,
            ),
            CutsomButtom(
              text: 'Register',
              onPressed: () {
                context.read<AuthBloc>().add(const AuthEventShouldRegister());
              },
              backgroundColor: null,
              buttonBackGround: Colors.white,
              wantBorder: true,
              textColor: const Color(0xff3C32A3),
            ),
            const SizedBox(
              height: 55,
            ),
            TextButton(
                onPressed: () {},
                child: const Text('Continue as guest',
                    style: TextStyle(color: Color(0xff42D3D8))))
          ],
        ),
      )),
    );
  }
}
