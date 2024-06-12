import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../utils/app_constants.dart';

class EditTextAlertDialog extends StatefulWidget {
  final Function(Color, double) onTextChanged;

  const EditTextAlertDialog({super.key, required this.onTextChanged});

  @override
  State<EditTextAlertDialog> createState() => _EditTextAlertDialogState();
}

class _EditTextAlertDialogState extends State<EditTextAlertDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Color _currentColor = AppConstants.textColor;

  double fontSize = AppConstants.textSize;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit text'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: _formKey,
              child: TextFormField(
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter something';
                  } else {
                    try {
                      // ignore: unused_local_variable
                      int box = int.parse(value);
                    } catch (e) {
                      return 'enter number';
                    }
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter new font size',
                ),
                onSaved: (newValue) {
                  if (newValue != null) {
                    fontSize = double.parse(newValue);
                  }
                },
              ),
            ),
            ColorPicker(
              pickerColor: _currentColor,
              onColorChanged: (Color color) {
                _currentColor = color;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              widget.onTextChanged(_currentColor, fontSize);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
