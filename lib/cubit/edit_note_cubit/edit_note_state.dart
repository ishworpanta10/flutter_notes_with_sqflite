part of 'edit_note_cubit.dart';

enum EditNoteStateStatus { initial, submitting, updated, error }

class EditNoteState extends Equatable {
  const EditNoteState({
    required this.id,
    required this.noteTitle,
    required this.noteDesc,
    required this.noteNumber,
    this.isImp,
    this.isFav,
    required this.status,
    required this.errorMessage,
  });

  factory EditNoteState.initial() {
    return const EditNoteState(
      id: "",
      noteTitle: "",
      noteDesc: "",
      noteNumber: 0,
      status: EditNoteStateStatus.initial,
      errorMessage: "",
    );
  }

  EditNoteState copyWith({
    String? id,
    String? noteTitle,
    String? noteDesc,
    int? noteNumber,
    bool? isImp,
    bool? isFav,
    EditNoteStateStatus? status,
    String? errorMessage,
  }) {
    return EditNoteState(
      id: id ?? this.id,
      noteTitle: noteTitle ?? this.noteTitle,
      noteDesc: noteDesc ?? this.noteDesc,
      noteNumber: noteNumber ?? this.noteNumber,
      isImp: isImp ?? this.isImp,
      isFav: isFav ?? this.isFav,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  final String id;
  final String noteTitle;
  final String noteDesc;
  final int noteNumber;
  final bool? isImp;
  final bool? isFav;
  final EditNoteStateStatus status;
  final String errorMessage;

  @override
  List<Object?> get props => [id, noteTitle, noteDesc, noteNumber, isImp, isFav, status, errorMessage];
}
