import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_register_app/Screens/forgot_password_screen.dart';
import 'package:login_register_app/Screens/home_screen.dart';
import 'package:login_register_app/Screens/loading_screen.dart';
import 'package:login_register_app/Screens/login_screen.dart';
import 'package:login_register_app/Screens/password_changed.dart';
import 'package:login_register_app/Screens/register_screen.dart';
import 'package:login_register_app/Screens/verify_email_view.dart';
import 'package:login_register_app/Screens/welcom_screen.dart';
import 'package:login_register_app/auth/bloc/auth_bloc.dart';
import 'package:login_register_app/auth/bloc/auth_event.dart';
import 'package:login_register_app/auth/bloc/auth_state.dart';
import 'package:login_register_app/auth/firebase_auth_provider.dart';
import 'package:login_register_app/widgets/route.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
      routes: {
        createOrUpdateNoteRoute: (context) => const HomeScreen(name: ''),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
              context: context,
              text: state.loadingText ?? 'Please wait a moment');
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return HomeScreen(
            name: state.user.email,
          );
        } else if (state is AuthStateVerifyEmail) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          return const WelcomeScreen();
        } else if (state is AuthStateFotgotPassword) {
          return ForgotPasswordScreen();
        } else if (state is AuthStateRegistering) {
          return const RegisterScreen();
        } else if (state is AuthStateLogin) {
          return LoginScreen();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
