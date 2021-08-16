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
}
