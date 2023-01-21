import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todolist/main.dart';

import '../models/note.dart';

class NoteWidget extends StatelessWidget {
  final Note note;
  const NoteWidget({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return Dismissible(
          onDismissed: (directon) {
            final prov = ref.read(notesProvider.notifier);
            prov.removeNote(note);
          },
          key: ValueKey(note.id),
          child: ListTile(
            title: Text(note.title),
            subtitle: Text(note.description),
          ),
        );
      },
    );
  }
}
