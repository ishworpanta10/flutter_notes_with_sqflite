part of 'note_fetch_cubit.dart';

enum NoteFetchStatus { initial, loading, loaded, error }

class NoteFetchState extends Equatable {
  const NoteFetchState({
    required this.noteList,
    required this.errorMessage,
    required this.status,
  });

  factory NoteFetchState.initial() {
    return const NoteFetchState(
      noteList: [],
      errorMessage: "",
      status: NoteFetchStatus.initial,
    );
  }

  final List<Note> noteList;
  final String errorMessage;
  final NoteFetchStatus status;

  @override
  List<Object> get props => [noteList, errorMessage, status];

  NoteFetchState copyWith({
    List<Note>? noteList,
    String? errorMessage,
    NoteFetchStatus? status,
  }) {
    return NoteFetchState(
      noteList: noteList ?? this.noteList,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }
}
