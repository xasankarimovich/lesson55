import 'package:flutter/material.dart';

import '../../viewmodels/note_view_model.dart';

class NotesAlertDialog extends StatefulWidget {
  final NoteController noteController;
  final bool isEdit;
  final int index;

  const NotesAlertDialog({
    super.key,
    required this.noteController,
    required this.isEdit,
    required this.index,
  });

  @override
  State<NotesAlertDialog> createState() => _NotesAlertDialogState();
}

class _NotesAlertDialogState extends State<NotesAlertDialog> {
  final List<TextEditingController> _controllers = [
    TextEditingController(),
    TextEditingController(),
  ];
  String error = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.isEdit ? 'Edit note' : 'Add note'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(error),
          TextField(
            controller: _controllers[0],
            decoration: const InputDecoration(
              hintText: 'Title for your note',
            ),
          ),
          Expanded(
            child: TextField(
              controller: _controllers[1],
              maxLines: null,
              expands: true,
              decoration: const InputDecoration(
                hintText: 'Start typing your notes here...',
                // border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_controllers[0].text.isNotEmpty &&
                _controllers[1].text.isNotEmpty) {
              if (!widget.isEdit) {
                widget.noteController.addNote(
                  noteTitle: _controllers[0].text,
                  noteContent: _controllers[1].text,
                );
              } else {
                widget.noteController.editNote(
                  noteIndex: widget.index,
                  noteTitle: _controllers[0].text,
                  noteContent: _controllers[1].text,
                );
              }

              Navigator.of(context).pop();
            } else {
              error = 'error: fill all the fields';
              setState(() {});
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
