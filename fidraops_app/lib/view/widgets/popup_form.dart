import 'package:flutter/material.dart';

enum PopupFormType {
  create,
  edit,
  delete,
}

class PopupForm extends StatelessWidget {
  final String title;
  final List<Widget> fields;
  final VoidCallback onSubmit;
  final PopupFormType? formType;

  const PopupForm({
    super.key,
    required this.title,
    required this.fields,
    required this.onSubmit,
    this.formType = PopupFormType.create,
  });

  @override
  Widget build(BuildContext context) {
    String submitButtonText;
    Color submitButtonColor;
    switch (formType) {
      case PopupFormType.edit:
        submitButtonText = "Save";
        submitButtonColor = Colors.blue;
        break;
      case PopupFormType.delete:
        submitButtonText = "Delete";
        submitButtonColor = Colors.red;
        break;
      case PopupFormType.create:
      default:
        submitButtonText = "Submit";
        submitButtonColor = Colors.green;
    }

    return AlertDialog(
      title: Text(title),
      content: SizedBox(
        width: MediaQuery.of(context).size.width < 600 ? MediaQuery.of(context).size.width * 0.9 : MediaQuery.of(context).size.width * 0.6,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: fields,
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            onSubmit();
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: submitButtonColor,
          ),
          child: Text(submitButtonText),
        ),
      ],
    );
  }
}
