import 'package:contacts_app/features/settings/presentation/cubit/host_cubit.dart';
import 'package:contacts_app/features/settings/presentation/cubit/host_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/app_bar.dart';

class SettingsScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _hostController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HostCubit, HostState>(builder: (context, state) {
      _hostController.text = state.host ?? "";
      return Scaffold(
        appBar: const CommonAppBar(title: 'Settings'),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _hostController,
                  decoration: const InputDecoration(labelText: 'Host'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a host';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      context.read<HostCubit>().setHost(_hostController.text);
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
