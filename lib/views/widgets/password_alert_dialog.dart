import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_constants.dart';

class PasswordAlertDialog extends StatefulWidget {
  const PasswordAlertDialog({super.key});

  @override
  State<PasswordAlertDialog> createState() => _PasswordAlertDialogState();
}

class _PasswordAlertDialogState extends State<PasswordAlertDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String newPassword = '';

  String previousPassword = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Change password'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter your previous password',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter something';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      previousPassword = newValue;
                    }
                  },
                  keyboardType: TextInputType.phone,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter something';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter your new password',
                  ),
                  onSaved: (newValue) {
                    if (newValue != null) {
                      newPassword = newValue;
                    }
                  },
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                if (newPassword != previousPassword) {
                  if (previousPassword == AppConstants.password) {
                    AppConstants.password = newPassword;
                    SharedPreferences preference = await SharedPreferences.getInstance();
                    preference.setString('password', newPassword);
                    Navigator.of(context).pop();
                  } else {
                    print('Invalid previous password');
                  }
                } else {
                  print('New password should be different from previous');
                }
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
