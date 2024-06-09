import 'package:contacts_app/features/auth/presentation/cubit/session_cubit.dart';
import 'package:contacts_app/features/auth/presentation/cubit/session_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/app_bar.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  void _login(BuildContext context) {
    final String email = _emailController.text;
    final String password = _passwordController.text;
    context.read<SessionCubit>().getSessionFromServer(email, password);
    Navigator.pop(context);
    Navigator.pushNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
      if (state is SessionLoading) {
        return const Scaffold(
            appBar: CommonAppBar(title: 'Login'),
            body: Center(child: CupertinoActivityIndicator()));
      }
      return Scaffold(
        appBar: CommonAppBar(title: 'Login'),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: () => _login(context),
                child: Text('Login'),
              )
            ],
          ),
        ),
      );
    });
  }
}
