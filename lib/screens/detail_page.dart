import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../cubit/cubit.dart';
import '../database/notes_db.dart';
import '../model/notes_model.dart';
import 'edit_note.dart';

class NoteDetailPage extends StatefulWidget {
  const NoteDetailPage({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NoteFetchCubit>(context).fetchSingleNote(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteFetchCubit, NoteFetchState>(
      builder: (context, state) {
        switch (state.status) {
          case NoteFetchStatus.loading:
            return const Center(child: CircularProgressIndicator());

          case NoteFetchStatus.error:
            return Center(child: Text(state.errorMessage));

          default:
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    BlocProvider.of<EditNoteCubit>(context).resetForm();
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                actions: [
                  _editButton(context, state.note!),
                  _deleteButton(context, state.note!.id!),
                ],
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              state.note!.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Icon(
                            state.note!.isImportant ? Icons.label_important : null,
                            color: Colors.teal,
                          ),
                          BlocBuilder<EditNoteCubit, EditNoteState>(
                            builder: (context, isFavState) {
                              return IconButton(
                                onPressed: () {
                                  BlocProvider.of<EditNoteCubit>(context)
                                    ..favToggle(isFav: isFavState.isFav == null ? !state.note!.isFav : !isFavState.isFav!)
                                    ..editNote(
                                      note: state.note!.copyWith(
                                        isFav: isFavState.isFav == null ? !state.note!.isFav : !isFavState.isFav!,
                                      ),
                                    );
                                },
                                icon: Icon(
                                  isFavState.isFav == null
                                      ? state.note!.isFav
                                          ? Icons.favorite
                                          : Icons.favorite_border
                                      : isFavState.isFav!
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                  color: isFavState.isFav == null
                                      ? state.note!.isFav
                                          ? Colors.red
                                          : null
                                      : isFavState.isFav!
                                          ? Colors.red
                                          : null,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        DateFormat.yMMMd().format(state.note!.createdTime),
                        style: const TextStyle(color: Colors.white38),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        state.note!.description,
                        style: const TextStyle(color: Colors.white70, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            );
        }
      },
    );
  }

  Widget _editButton(BuildContext context, Note note) => IconButton(
        icon: const Icon(Icons.edit_outlined),
        onPressed: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EditNote(note: note),
          ));
          await context.read<NoteFetchCubit>().fetchSingleNote(id: note.id!);
        },
      );

  Widget _deleteButton(BuildContext context, int id) => IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {
          await NotesDatabase.instance.delete(id);
          Navigator.of(context).pop();
        },
      );
}
