import 'package:contacts_app/features/settings/presentation/pages/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/presentation/cubit/session_cubit.dart';
import '../../features/auth/presentation/cubit/session_state.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CommonAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
        builder: (sessionContext, sessionState) {
      return AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
          sessionState is SessionLoaded ? IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              sessionContext.read<SessionCubit>().clearSession();
            },
          ) : SizedBox(),
        ],
      );
    });
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
