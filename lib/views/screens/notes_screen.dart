import 'package:flutter/material.dart';
import 'package:settings_page/models/note_model.dart';
import 'package:settings_page/notifiers/note_notifier.dart';
import 'package:settings_page/viewmodels/note_view_model.dart';
import 'package:settings_page/views/widgets/custom_note_container.dart';
import 'package:settings_page/views/widgets/note_alert_dialog.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NoteController noteController = NoteNotifier.of(context);
    return ListenableBuilder(
      listenable: noteController,
      builder: (BuildContext context, Widget? child) => Scaffold(
        appBar: AppBar(
          title: const Text('Your notes'),
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => NotesAlertDialog(
                      noteController: noteController,
                      isEdit: false,
                      index: 0,
                    ),
                  );
                },
                child: const Text('Add note'),
              ),
            ),
          ],
        ),
        // body: FlutterLogo(),
        body: FutureBuilder(
          future: noteController.notesList,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (!snapshot.hasData || snapshot.hasError) {
              print(snapshot.error);
              return const Center(
                child: Text('errror: snapshot'),
              );
            } else {
              List<NoteModel> noteListData = snapshot.data;
              return noteListData.isEmpty
                  ? const Center(
                      child: Text('Add notes'),
                    )
                  : ListView.builder(
                      itemCount: noteListData.length,
                      itemBuilder: (context, index) {
                        return CustomNoteContainer(
                          note: noteListData[index],
                          index: noteListData[index].noteId,
                          noteController: noteController,
                        );
                      },
                    );
            }
          },
        ),
      ),
    );
  }
}
