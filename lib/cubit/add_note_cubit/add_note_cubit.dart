import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../database/notes_db.dart';
import '../../model/notes_model.dart';

part 'add_note_state.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit() : super(AddNoteState.initial());

  void titleChanged({required String title}) {
    emit(state.copyWith(noteTitle: title));
  }

  void descriptionChanged({required String description}) {
    emit(state.copyWith(noteDesc: description));
  }

  void numberChanged({required int number}) {
    emit(state.copyWith(
      noteNumber: number,
    ));
  }

  void changeImpSwitch({required bool isImp}) {
    emit(state.copyWith(isImp: isImp));
  }

  void resetForm() {
    emit(AddNoteState.initial());
  }

  Future<void> addNote() async {
    emit(state.copyWith(status: AddNoteStateStatus.submitting));
    try {
      final note = Note(
        title: state.noteTitle,
        description: state.noteDesc,
        number: state.noteNumber,
        isImportant: state.isImp,
        createdTime: DateTime.now(),
      );
      await NotesDatabase.instance.create(note);
      emit(AddNoteState.initial());
      emit(state.copyWith(status: AddNoteStateStatus.submitted));
    } catch (e) {
      emit(
        state.copyWith(
          status: AddNoteStateStatus.error,
          errorMessage: "can not add note",
        ),
      );
      // print("Something Unknown Error: ${e}");
    }
  }

  Future<void> updateNote({required Note note}) async {
    emit(state.copyWith(status: AddNoteStateStatus.submitting));
    try {
      final updatedNote = note.copyWith(
        title: state.noteTitle,
        description: state.noteDesc,
        number: state.noteNumber,
        isImportant: state.isImp,
      );
      await NotesDatabase.instance.update(updatedNote);
      emit(AddNoteState.initial());
      emit(state.copyWith(status: AddNoteStateStatus.submitted));
    } catch (e) {
      emit(
        state.copyWith(
          status: AddNoteStateStatus.error,
          errorMessage: "can not add note",
        ),
      );
      // print("Something Unknown Error: ${e}");
    }
  }
}
