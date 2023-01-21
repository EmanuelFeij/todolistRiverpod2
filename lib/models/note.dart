class Note {
  final String title;
  final String description;
  final String id;

  Note({required this.title, required this.description})
      : id = DateTime.fromMicrosecondsSinceEpoch.toString();
}

typedef Notes = List<Note>;
