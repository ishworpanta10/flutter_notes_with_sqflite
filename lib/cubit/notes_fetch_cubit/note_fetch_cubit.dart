import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../database/notes_db.dart';
import '../../model/notes_model.dart';

part 'note_fetch_state.dart';

class NoteFetchCubit extends Cubit<NoteFetchState> {
  NoteFetchCubit() : super(NoteFetchState.initial());

  Future<void> fetchAllNotes() async {
    emit(state.copyWith(status: NoteFetchStatus.loading));
    try {
      final noteList = await NotesDatabase.instance.readAllNotes();
      emit(
        state.copyWith(noteList: noteList, status: NoteFetchStatus.loaded),
      );
    } catch (err) {
      emit(
        state.copyWith(
          status: NoteFetchStatus.error,
          errorMessage: "Something went wrong !",
        ),
      );
    }
  }

  Future<Note?> fetchSingleNote({required int id}) async {
    emit(state.copyWith(status: NoteFetchStatus.loading));
    try {
      final note = await NotesDatabase.instance.readNote(id);
      emit(
        state.copyWith(note: note, status: NoteFetchStatus.loaded),
      );
      return note;
    } catch (err) {
      emit(
        state.copyWith(
          status: NoteFetchStatus.error,
          errorMessage: "Something went wrong !",
        ),
      );
    }
  }
}
