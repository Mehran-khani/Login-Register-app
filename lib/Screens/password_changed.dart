import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_register_app/auth/bloc/auth_bloc.dart';
import 'package:login_register_app/auth/bloc/auth_event.dart';
import 'package:login_register_app/widgets/custom_button.dart';

class PasswordChangedScreen extends StatelessWidget {
  const PasswordChangedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: 170,
              child: Image.asset('assets/images/logo.png'),
            ),
            const Text(
              'Password Changed!',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
            ),
            const Text(
              'Your password has been changed successfully.',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff8391A1)),
            ),
            const SizedBox(
              height: 18,
            ),
            Image.asset(
              'assets/images/approval.gif',
              width: 300,
              height: 300,
            ),
            CutsomButtom(
                text: 'Login',
                onPressed: () {
                  context.read<AuthBloc>().add(const AuthEventShouldLogin());
                })
          ],
        ),
      )),
    );
  }
}
