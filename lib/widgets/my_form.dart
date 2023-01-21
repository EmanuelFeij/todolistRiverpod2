import 'package:flutter/material.dart';

class MyCustomForm extends StatefulWidget {
  final void Function(String title, String description) onSubmit;
  const MyCustomForm({super.key, required this.onSubmit});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  bool controllersNotEmpty() =>
      titleController.text.isNotEmpty && descriptionController.text.isNotEmpty;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTitle = Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: TextField(
        decoration: decoration("Title"),
        controller: titleController,
      ),
    );

    final textDescription = Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: TextField(
        decoration: decoration("Description"),
        controller: descriptionController,
      ),
    );

    final addButton = TextButton(
      onPressed: () {
        if (controllersNotEmpty()) {
          widget.onSubmit(titleController.text, descriptionController.text);
          titleController.text = "";
          descriptionController.text = "";
          Navigator.of(context).pop();
        }
      },
      child: const Text("Add New Note"),
    );

    final closeButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text(
        "Close",
        style: TextStyle(color: Colors.red),
      ),
    );

    return AlertDialog(
      title: Center(child: Text("ADDING A NOTE")),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        closeButton,
        addButton,
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          textTitle,
          textDescription,
        ],
      ),
    );
  }
}

InputDecoration decoration(String hint) => InputDecoration(
      border: const OutlineInputBorder(),
      label: Text(hint),
    );
