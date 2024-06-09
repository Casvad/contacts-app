import 'package:contacts_app/features/contacts/presentation/cubit/contact_all_cubit.dart';
import 'package:contacts_app/features/contacts/presentation/cubit/contact_all_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/app_bar.dart';
import '../../../auth/presentation/cubit/session_cubit.dart';
import '../../../auth/presentation/cubit/session_state.dart';
import '../dialogs/single_contact_dialog.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
        builder: (sessionContext, sessionState) {
      if (sessionState is SessionLoading) {
        return const Scaffold(
            appBar: CommonAppBar(title: 'Contact app'),
            body: Center(child: CupertinoActivityIndicator()));
      } else if (sessionState is NotLoggedSession) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/login-selector');
        });
      } else if (sessionState is SessionLoaded) {

        return Scaffold(
          appBar: CommonAppBar(
              title: 'Welcome ${sessionState.sessionModel?.email}'),
          body: BlocBuilder<ContactAllCubit, ContactAllState>(
              builder: (contactContext, contactState) {
                print("Contacts loaded with size: ${contactState.contacts?.length ?? 0}");
            if (contactState is LoadingContactAllState) {
              return const Center(child: CupertinoActivityIndicator());
            }
            return ListView.builder(
              itemCount: contactState.contacts?.length ?? 0,
              itemBuilder: (context, index) {
                final contact = contactState.contacts?[index];
                return ListTile(
                  title: Text(contact?.name ?? ""),
                  subtitle: Text(contact?.email ?? ""),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              contactContext
                                  .read<ContactAllCubit>()
                                  .findContactById(contact?.id ?? 0);
                              return UpdateContactDialog(
                                  isCreation: false, contact: contact);
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          contactContext
                              .read<ContactAllCubit>()
                              .deleteContact(contact?.id ?? 0);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const UpdateContactDialog(
                      isCreation: true, contact: null);
                },
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      }

      return const Scaffold(
          appBar: CommonAppBar(title: 'Contact app invalid state'),
          body: Center(child: CupertinoActivityIndicator()));
    });
  }
}
