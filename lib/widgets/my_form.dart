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

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTitle = TextField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Title",
      ),
      controller: titleController,
    );
    final textDescription = TextField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Description",
        ),
        controller: descriptionController);

    final textButton = TextButton(
      onPressed: () {
        if (titleController.text.isNotEmpty &&
            descriptionController.text.isNotEmpty) {
          widget.onSubmit(titleController.text, descriptionController.text);
          titleController.text = "";
          descriptionController.text = "";
        }
      },
      child: const Text("Add New Note"),
    );
    return Column(
      children: [textTitle, textDescription, textButton],
    );
  }
}
