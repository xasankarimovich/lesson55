import 'package:flutter/cupertino.dart';

import '../models/note_model.dart';
import '../services/database/note_database.dart';

class NoteController with ChangeNotifier {
  List<NoteModel> _notesList = [];

  final NoteDatabase _noteDatabase = NoteDatabase();

  Future<List<NoteModel>> get notesList async {
    _notesList = await _noteDatabase.getNotes();
    return [..._notesList];
  }

  void addNote({
    required String noteTitle,
    required String noteContent,
  }) async {
    await _noteDatabase.addNote({
      'title': noteTitle,
      'content': noteContent,
      'date': DateTime.now().toString(),
    });

    notifyListeners();
  }

  void editNote({
    required int noteIndex,
    required String noteTitle,
    required String noteContent,
  }) async {
    await _noteDatabase.editNote(noteIndex, {
      'title': noteTitle,
      'content': noteContent,
      'date': DateTime.now().toString(),
    });
    notifyListeners();
  }

  void deleteNote({
    required int noteIndex,
  }) async {
    await _noteDatabase.deleteNote(noteIndex);
    notifyListeners();
  }
}
