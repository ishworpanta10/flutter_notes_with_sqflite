import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../database/notes_db.dart';
import '../model/notes_model.dart';
import '../widget/note_card_widget.dart';
import 'add_edit_note.dart';
import 'detail_page.dart';

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    getNotes();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();
    super.dispose();
  }

  Future getNotes() async {
    setState(() => isLoading = true);
    notes = await NotesDatabase.instance.readAllNotes();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Notes',
            style: TextStyle(fontSize: 24),
          ),
        ),
        body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : notes.isEmpty
                  ? const Text(
                      'No Notes',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  : buildNotes(),
        ),
        floatingActionButton: FloatingActionButton(
          // backgroundColor: Colors.black,
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddEditNote()),
            );
            await getNotes();
          },
          child: const Icon(Icons.add),
        ),
      );

  Widget buildNotes() => StaggeredGridView.countBuilder(
        padding: const EdgeInsets.all(8),
        itemCount: notes.length,
        staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final note = notes[index];

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NoteDetailPage(noteId: note.id!),
              ));

              await getNotes();
            },
            child: NoteCardWidget(note: note, index: index),
          );
        },
      );
}
