import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todolist/models/note.dart';
import 'package:todolist/state/note_state_notifier.dart';
import 'package:todolist/widgets/my_form.dart';
import 'package:todolist/widgets/note_widget.dart';

import 'widgets/new_note_dialog.dart';

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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    var outlinedButton = Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: width * 0.5,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.blueAccent)),
          onPressed: () => showDialog(
            context: context,
            builder: (_) {
              return Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final notesAdder = ref.read(notesProvider.notifier).addNote;
                  return MyCustomForm(onSubmit: notesAdder);
                },
              );
            },
          ),
          child: const Text('ADD NOTE'),
        ),
      ),
    );

    var listConsumer =
        Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
      final notes = ref.watch(notesProvider);
      return Expanded(
          child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(),
                  child: NoteWidget(
                    note: notes[index],
                  ),
                );
              }));
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
      ),
      body: Column(
        children: [
          outlinedButton,
          listConsumer,
        ],
      ),
    );
  }
}

// StateNotifierProvider
final notesProvider = StateNotifierProvider<NotesListNotifier, Notes>(
    (ref) => NotesListNotifier());

// StateNotifier

