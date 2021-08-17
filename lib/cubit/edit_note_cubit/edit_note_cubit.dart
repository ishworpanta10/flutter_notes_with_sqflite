import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../database/notes_db.dart';
import '../../model/notes_model.dart';
import '../cubit.dart';

part 'edit_note_state.dart';

class EditNoteCubit extends Cubit<EditNoteState> {
  EditNoteCubit({required NoteFetchCubit noteFetchCubit})
      : _noteFetchCubit = noteFetchCubit,
        super(EditNoteState.initial()) {
    final note = noteFetchCubit.state.note;
    emit(state.copyWith(
      noteTitle: note?.title,
      noteDesc: note?.description,
      noteNumber: note?.number,
      isImp: note?.isImportant,
    ));
  }
  final NoteFetchCubit _noteFetchCubit;

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
    emit(EditNoteState.initial());
  }

  Future<void> editNote({required Note note}) async {
    emit(state.copyWith(status: EditNoteStateStatus.submitting));
    try {
      print("Bool value state ${state.isImp}");
      print("Bool value initial ${note.isImportant}");

      final updatedNote = note.copyWith(
        title: state.noteTitle.isNotEmpty ? state.noteTitle : note.title,
        description: state.noteDesc.isNotEmpty ? state.noteDesc : note.description,
        number: state.noteNumber != note.number ? state.noteNumber : note.number,
        isImportant: state.isImp != note.isImportant ? state.isImp : note.isImportant,
      );

      await NotesDatabase.instance.update(updatedNote);
      emit(EditNoteState.initial());
      emit(state.copyWith(status: EditNoteStateStatus.updated));
    } catch (e) {
      emit(
        state.copyWith(
          status: EditNoteStateStatus.error,
          errorMessage: "note can not be updated !",
        ),
      );
      // print("Something Unknown Error: ${e}");
    }
  }
}
