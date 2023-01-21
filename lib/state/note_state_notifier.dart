import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/note.dart';

class NotesListNotifier extends StateNotifier<Notes> {
  NotesListNotifier() : super([]);
  void addNote(String title, String description) {
    final note = Note(title: title, description: description);
    state = [...state, note];
  }

  void removeNote(Note note) {
    state = [
      for (final n in state)
        if (n.id != note.id) n,
    ];
  }

  Notes get notes => state;
}
