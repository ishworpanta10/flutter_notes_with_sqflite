part of 'add_note_cubit.dart';

enum AddNoteStateStatus { initial, submitting, submitted, error }

class AddNoteState extends Equatable {
  const AddNoteState({
    required this.noteTitle,
    required this.noteDesc,
    required this.noteNumber,
    required this.isImp,
    required this.isFav,
    required this.status,
    required this.errorMessage,
  });

  factory AddNoteState.initial() {
    return const AddNoteState(
      noteTitle: "",
      noteDesc: "",
      isImp: false,
      isFav: false,
      noteNumber: 0,
      status: AddNoteStateStatus.initial,
      errorMessage: "",
    );
  }

  AddNoteState copyWith({
    String? noteTitle,
    String? noteDesc,
    int? noteNumber,
    bool? isImp,
    bool? isFav,
    AddNoteStateStatus? status,
    String? errorMessage,
  }) {
    return AddNoteState(
      noteTitle: noteTitle ?? this.noteTitle,
      noteDesc: noteDesc ?? this.noteDesc,
      noteNumber: noteNumber ?? this.noteNumber,
      isImp: isImp ?? this.isImp,
      isFav: isFav ?? this.isFav,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  final String noteTitle;
  final String noteDesc;
  final int noteNumber;
  final bool isImp;
  final bool isFav;
  final AddNoteStateStatus status;
  final String errorMessage;

  @override
  List<Object?> get props => [noteTitle, noteDesc, noteNumber, isImp, isFav, status, errorMessage];
}
