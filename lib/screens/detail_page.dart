import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../cubit/cubit.dart';
import '../database/notes_db.dart';
import '../model/notes_model.dart';
import 'edit_note.dart';

class NoteDetailPage extends StatelessWidget {
  const NoteDetailPage({Key? key, required this.note}) : super(key: key);
  final Note note;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
          actions: [
            _editButton(context, note),
            _deleteButton(context, note.id!),
          ],
        ),
        body: Center(
          child: BlocBuilder<NoteFetchCubit, NoteFetchState>(
            builder: (context, state) {
              switch (state.status) {
                case NoteFetchStatus.loading:
                  return const CircularProgressIndicator();

                case NoteFetchStatus.error:
                  return Text(state.errorMessage);

                default:
                  return Padding(
                    padding: const EdgeInsets.all(12),
                    child: ListView(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      children: [
                        Text(
                          state.note?.title ?? note.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          DateFormat.yMMMd().format(note.createdTime),
                          style: const TextStyle(color: Colors.white38),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.note?.description ?? note.description,
                          style: const TextStyle(color: Colors.white70, fontSize: 18),
                        ),
                      ],
                    ),
                  );
              }
            },
          ),
        ),
      );

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
