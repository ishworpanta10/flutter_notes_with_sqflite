import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/add_note_cubit/add_note_cubit.dart';
import '../widget/note_form_widget.dart';

class AddNote extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [buildButton(context)],
        ),
        body: Form(
          key: _formKey,
          child: NoteFormWidget(
            onChangedImportant: (isImportant) {
              context.read<AddNoteCubit>().changeImpSwitch(isImp: isImportant);
            },
            onChangedNumber: (number) {
              context.read<AddNoteCubit>().numberChanged(number: number);
            },
            onChangedTitle: (title) {
              context.read<AddNoteCubit>().titleChanged(title: title);
            },
            onChangedDescription: (description) {
              context.read<AddNoteCubit>().descriptionChanged(description: description);
            },
          ),
        ),
      );

  Widget buildButton(BuildContext context) {
    return BlocBuilder<AddNoteCubit, AddNoteState>(
      builder: (context, state) {
        final validAddNote = state.noteDesc.trim().isNotEmpty && state.noteDesc.trim().isNotEmpty;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.white,
              // primary: validNote ? Colors.blue : Colors.grey.shade700,
            ),
            onPressed: validAddNote ? () => _addNote(context) : null,
            child: const Text('Save'),
          ),
        );
      },
    );
  }

  Future<void> _addNote(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      await context.read<AddNoteCubit>().addNote();
      Navigator.pop(context);
    }
  }

  // Future<void> addOrUpdateNote(BuildContext context, AddNoteState state) async {
  //   final isFormValid = _formKey.currentState!.validate();
  //
  //   if (isFormValid) {
  //     final isUpdating = note != null;
  //     if (isUpdating) {
  //       // await updateNote();
  //     } else {
  //       await addNote(state);
  //     }
  //     Navigator.of(context).pop();
  //   }
  // }
  //
  // // Future updateNote() async {
  // //   final updatedNote = note.copyWith(
  // //     isImportant: isImportant,
  // //     number: number,
  // //     title: title,
  // //     description: description,
  // //   );
  // //
  // //   await NotesDatabase.instance.update(note);
  // // }
  //
  // Future addNote(AddNoteState state) async {
  //   final note = Note(
  //     title: sta,
  //     isImportant: isImportant,
  //     number: number,
  //     description: description,
  //     createdTime: DateTime.now(),
  //   );
  //
  //   await NotesDatabase.instance.create(note);
  // }
}
