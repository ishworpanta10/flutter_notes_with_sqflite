import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../cubit/cubit.dart';
import '../database/notes_db.dart';
import '../model/notes_model.dart';
import 'add_edit_note.dart';

class NoteDetailPage extends StatefulWidget {
  const NoteDetailPage({
    Key? key,
    required this.noteId,
  }) : super(key: key);

  final int noteId;

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  final dbInstance = NotesDatabase.instance;

  late Note note;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getNote();
  }

  Future getNote() async {
    setState(() => isLoading = true);
    note = await dbInstance.readNote(widget.noteId);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [
            editButton(),
            deleteButton(),
          ],
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(12),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    Text(
                      note.title,
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
                      note.description,
                      style: const TextStyle(color: Colors.white70, fontSize: 18),
                    )
                  ],
                ),
              ),
      );

  Widget editButton() => IconButton(
      icon: const Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) {
          return;
        }
        //TODO EDit note
        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddNote(),
        ));
        await BlocProvider.of<NoteFetchCubit>(context).fetchAllNotes();
      });

  Widget deleteButton() => IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {
          await NotesDatabase.instance.delete(widget.noteId);

          Navigator.of(context).pop();
          await BlocProvider.of<NoteFetchCubit>(context).fetchAllNotes();
        },
      );
}
