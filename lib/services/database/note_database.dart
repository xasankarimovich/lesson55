

import '../../models/note_model.dart';
import 'local_database.dart';

class NoteDatabase {
  final LocalDatabase _localDatabase = LocalDatabase();
  final String _tableName = 'notes';

  Future<List<NoteModel>> getNotes() async {
    final Database db = await _localDatabase.database;
    await deleteNote(1);
    final List<Map<String, Object?>> response = await db.query(_tableName);
    print(response);
    List<NoteModel> loadedData = [];
    for (var each in response) {
      loadedData.add(
        NoteModel.fromMap(each),
      );
    }
    return loadedData;
  }

  Future<void> addNote(Map<String, dynamic> data) async {
    final db = await _localDatabase.database;
    await db.insert(_tableName, data);
  }

  Future<void> editNote(int id, Map<String, dynamic> newData) async {
    final db = await _localDatabase.database;
    await db.update(
      _tableName,
      newData,
      where: 'id = $id',
    );

  }

  Future<void> deleteNote(int id) async {
    final db = await _localDatabase.database;
    db.delete(
      _tableName,
      where: 'id = $id',
    );
  }
}
