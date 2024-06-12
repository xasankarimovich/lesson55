import 'package:flutter/material.dart';

import '../../models/note_model.dart';
import '../../viewmodels/note_view_model.dart';
import 'custom_icon_button.dart';
import 'note_alert_dialog.dart';

class CustomNoteContainer extends StatelessWidget {
  final int index;
  final NoteController noteController;
  final NoteModel note;
  const CustomNoteContainer({
    super.key,
    required this.index,
    required this.noteController,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: const Color(0xFFDFDBDB),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(note.noteTitle),
              Text(
                note.noteCreatedDate
                    .toString()
                    .split(' ')[0],
              ),
            ],
          ),
          Text(note.noteContent),
          Row(
            children: [
              CustomIconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => NotesAlertDialog(
                        noteController: noteController,
                        isEdit: true,
                        index: index,
                      ),
                    );
                  },
                  icon: Icons.edit),
              CustomIconButton(
                onPressed: () {
                  noteController.deleteNote(noteIndex: index);
                },
                icon: Icons.delete,
              ),
            ],
          )
        ],
      ),
    );
  }
}
