import 'package:contacts_app/features/auth/presentation/cubit/session_cubit.dart';
import 'package:contacts_app/features/auth/presentation/cubit/session_state.dart';
import 'package:contacts_app/features/auth/presentation/pages/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/app_bar.dart';
import 'login_screen.dart';

class LoginSelectorScreen extends StatelessWidget {
  const LoginSelectorScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
      if (state is SessionLoading) {
        return Scaffold(
            appBar: CommonAppBar(title: 'Login Methods'),
            body: Center(child: CupertinoActivityIndicator()));
      }
      return Scaffold(
        appBar: CommonAppBar(title: 'Login Methods'),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20), // Button padding
                  textStyle: TextStyle(fontSize: 16), // Button text style
                ),
                child: Text('Login'),
              ),
              SizedBox(height: 20), // Add some space between buttons
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20), // Button padding
                  textStyle: TextStyle(fontSize: 16), // Button text style
                ),
                child: Text('Register'),
              ),
            ],
          ),
        ),
      );
    });
  }
}
