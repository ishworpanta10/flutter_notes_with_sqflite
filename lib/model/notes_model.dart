import 'model_constants.dart';

class Note {
  const Note({this.id, required this.isImportant, required this.isFav, required this.number, required this.title, required this.description, required this.createdTime});

  factory Note.fromJson(Map<String, Object?> json) => Note(
        id: json[Id] as int?,
        isImportant: json[IsImportant] == 1,
        isFav: json[IsFav] == 1,
        number: json[Number] as int,
        title: json[Title] as String,
        description: json[Description] as String,
        createdTime: DateTime.parse(json[Time] as String),
      );

  Map<String, Object?> toJson() => {
        Id: id,
        Title: title,
        IsImportant: isImportant ? 1 : 0,
        IsFav: isFav ? 1 : 0,
        Number: number,
        Description: description,
        Time: createdTime.toIso8601String(),
      };

  Note copyWith({int? id, bool? isImportant, bool? isFav, int? number, String? title, String? description, DateTime? createdTime}) {
    return Note(id: id ?? this.id, isImportant: isImportant ?? this.isImportant, isFav: isFav ?? this.isFav, number: number ?? this.number, title: title ?? this.title, description: description ?? this.description, createdTime: createdTime ?? this.createdTime);
  }

  final int? id;
  final bool isImportant;
  final bool isFav;
  final int number;
  final String title;
  final String description;
  final DateTime createdTime;
}
