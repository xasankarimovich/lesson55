class NoteModel {
  final int noteId;
  String noteTitle;
  String noteContent;
  final String noteCreatedDate;

  NoteModel({
    required this.noteId,
    required this.noteTitle,
    required this.noteContent,
    required this.noteCreatedDate,
  });

  factory NoteModel.fromMap(Map<String, dynamic> data) {
    return NoteModel(
      noteId: data['id'],
      noteTitle: data['title'],
      noteContent: data['content'],
      noteCreatedDate: data['date'],
    );
  }
}
