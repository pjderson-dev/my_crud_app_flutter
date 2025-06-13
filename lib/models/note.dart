import '../database_helper.dart';

class Note {
  final int? id;
  final String title;
  final String content;

  Note({this.id, required this.title, required this.content});

  Map<String, dynamic> toMap() {
    return {
      NoteFields.title: title,
      NoteFields.content: content,
      if (id != null) NoteFields.id: id,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map[NoteFields.id] as int?,
      title: map[NoteFields.title] as String,
      content: map[NoteFields.content] as String,
    );
  }
  @override
  String toString() {
    return 'Note(id: $id, title: $title, content: $content)';
  }
}
