class Note {
  final int id;
  final String title;
  final String description;
  final bool isDone;
  final DateTime date;

  Note({
    this.id = 0,
    required this.title,
    required this.description,
    this.isDone = false,
    required this.date,
  });



  Note copyWith({
    int? id,
    String? title,
    String? description,
    bool? isDone,
    DateTime? date,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      date: date ?? this.date,
    );
  }





  /// Converts a JSON map to a Note object
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String,
      description: json['description'] as String,
      isDone: json['isDone'] as bool? ?? false,
      date: DateTime.parse(json['creationDate'] as String),
    );
  }

  /// Converts a Note object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone,
      'creationDate': date.toIso8601String(),
    };
  }
}
