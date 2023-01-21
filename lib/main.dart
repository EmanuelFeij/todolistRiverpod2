import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todolist/models/note.dart';
import 'package:todolist/state/note_state_notifier.dart';
import 'package:todolist/widgets/my_form.dart';
import 'package:todolist/widgets/note_widget.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),
      body: Column(
        children: [
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final notesAdder = ref.read(notesProvider.notifier).addNote;
              return MyCustomForm(onSubmit: notesAdder);
            },
          ),
          Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final notes = ref.watch(notesProvider);
            return Expanded(
                child: ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return NoteWidget(
                        note: notes[index],
                      );
                    }));
          }),
        ],
      ),
    );
  }
}

// StateNotifierProvider
final notesProvider = StateNotifierProvider<NotesListNotifier, Notes>(
    (ref) => NotesListNotifier());

// StateNotifier

