import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/contact.dart';
import '../cubit/contact_all_cubit.dart';

class UpdateContactDialog extends StatefulWidget {
  final ContactModel? contact;
  final bool isCreation;

  const UpdateContactDialog(
      {super.key, this.contact, required this.isCreation});

  @override
  _UpdateContactDialogState createState() =>
      _UpdateContactDialogState(isCreation: isCreation);
}

class _UpdateContactDialogState extends State<UpdateContactDialog> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  final bool isCreation;

  _UpdateContactDialogState({this.isCreation = false});

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.contact?.name);
    _emailController = TextEditingController(text: widget.contact?.email);
    _phoneController = TextEditingController(text: widget.contact?.phone);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
          Text('Contact ${isCreation ? "Creation" : "${widget.contact?.id}"}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: _phoneController,
            decoration: InputDecoration(labelText: 'Phone'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (isCreation) {
              final updatedContact = ContactModel(
                  name: _nameController.text,
                  email: _emailController.text,
                  phone: _phoneController.text,
                  prefixPhone: "+57");
              context.read<ContactAllCubit>().createContact(updatedContact);
            } else {
              final updatedContact = widget.contact!.copyWith(
                  name: _nameController.text,
                  email: _emailController.text,
                  phone: _phoneController.text,
                  prefixPhone: "+57");
              context.read<ContactAllCubit>().updateContact(updatedContact);
            }
            Navigator.of(context).pop();
          },
          child: Text(isCreation ? 'Create' : 'Update'),
        ),
      ],
    );
  }
}
