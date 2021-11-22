import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'notes_fav_fetch_state.dart';

class NotesFavFetchCubit extends Cubit<NotesFavFetchState> {
  NotesFavFetchCubit() : super(NotesFavFetchInitial());
}
