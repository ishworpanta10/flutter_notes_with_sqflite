import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';
import '../model/notes_model.dart';
import '../widget/note_form_widget.dart';

class EditNote extends StatelessWidget {
  EditNote({Key? key, required this.note}) : super(key: key);
  final Note note;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [buildButton(context)],
        ),
        body: Form(
          key: _formKey,
          child: NoteFormWidget(
            title: note.title,
            description: note.description,
            isImportant: note.isImportant,
            isFav: note.isFav,
            number: note.number,
            onChangedImportant: (isImportant) {
              context.read<EditNoteCubit>().changeImpSwitch(isImp: isImportant);
            },
            onChangedFav: (isFav) {
              context.read<EditNoteCubit>().changeFavSwitch(isFav: isFav);
            },
            onChangedNumber: (number) {
              context.read<EditNoteCubit>().numberChanged(number: number);
            },
            onChangedTitle: (title) {
              context.read<EditNoteCubit>().titleChanged(title: title);
            },
            onChangedDescription: (description) {
              context.read<EditNoteCubit>().descriptionChanged(description: description);
            },
          ),
        ),
      );

  Widget buildButton(BuildContext context) {
    return BlocBuilder<EditNoteCubit, EditNoteState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.white,
            ),
            onPressed: () => _updateNote(context),
            child: const Text('Update'),
          ),
        );
      },
    );
  }

  Future<void> _updateNote(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      await context.read<EditNoteCubit>().editNote(note: note);
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
