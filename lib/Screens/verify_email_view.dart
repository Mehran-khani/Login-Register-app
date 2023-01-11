import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_register_app/auth/bloc/auth_bloc.dart';
import 'package:login_register_app/auth/bloc/auth_event.dart';
import 'package:login_register_app/widgets/custom_button.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 300,
                width: 170,
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
              const Text(
                "Email Verification",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff1E232C)),
              ),
              const SizedBox(
                height: 14,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 22),
                child: Text(
                  "If you haven't received a verification email yet, press the button below",
                  style: TextStyle(color: Color(0xff838BA1)),
                ),
              ),
              const SizedBox(
                height: 33,
              ),
              // TextButton(
              //   onPressed: () {
              //     context
              //         .read<AuthBloc>()
              //         .add(const AuthEventSendEmailVerification());
              //   },
              //   child: const Text('Send email verification'),
              // ),
              CutsomButtom(
                  text: 'Send email verification',
                  onPressed: () {
                    context
                        .read<AuthBloc>()
                        .add(const AuthEventSendEmailVerification());
                  }),
              const SizedBox(
                height: 18,
              ),
              // TextButton(
              //   onPressed: () async {
              //     context.read<AuthBloc>().add(const AuthEventLogOut());
              //   },
              //   child: const Text('Restart'),
              // ),
              CutsomButtom(
                  text: 'Verified? Login',
                  onPressed: () {
                    context.read<AuthBloc>().add(const AuthEventShouldLogin());
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
