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

  Future<void> deleteNote({required int id}) async {
    await NotesDatabase.instance.delete(id);
  }

  Future<void> addNote() async {
    emit(state.copyWith(status: AddNoteStateStatus.submitting));
    try {
      print("Bool value ${state.isImp}");
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
}
