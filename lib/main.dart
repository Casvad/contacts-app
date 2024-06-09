import 'package:contacts_app/features/auth/presentation/cubit/session_cubit.dart';
import 'package:contacts_app/features/auth/presentation/pages/register_screen.dart';
import 'package:contacts_app/features/contacts/presentation/cubit/contact_all_cubit.dart';
import 'package:contacts_app/features/settings/presentation/pages/settings_screen.dart';
import 'package:contacts_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'features/auth/presentation/pages/login_screen.dart';
import 'features/auth/presentation/pages/login_selector_screen.dart';
import 'features/contacts/presentation/pages/contact_screen.dart';
import 'features/settings/presentation/cubit/host_cubit.dart';

main() async {
  await dotenv.load(fileName: "assets/.env");
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider.value(value: sl<SessionCubit>()..getUserSession()),
                BlocProvider.value(value: sl<HostCubit>()..getHost()),
                BlocProvider.value(value: sl<ContactAllCubit>()..loadAllContacts()),
              ],
              child: MaterialApp(
                title: 'Contacts app',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                home: ContactScreen(),
                routes: {
                  '/login-selector': (context) => LoginSelectorScreen(),
                  '/login': (context) => LoginScreen(),
                  '/register': (context) => RegisterScreen(),
                  '/settings': (context) => SettingsScreen(),
                  '/home': (context) => ContactScreen(),
                },
              ),
            ));
  }
}
