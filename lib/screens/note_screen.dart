import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../cubit/cubit.dart';
import '../cubit/notes_fetch_cubit/note_fetch_cubit.dart';
import '../model/notes_model.dart';
import '../widget/note_card_widget.dart';
import 'add_note.dart';
import 'detail_page.dart';

class NotesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("===============Build Called===============");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: Center(
        child: BlocBuilder<NoteFetchCubit, NoteFetchState>(
          builder: (context, state) {
            // print("Bullder called");
            switch (state.status) {
              case NoteFetchStatus.loading:
                return const CircularProgressIndicator();

              case NoteFetchStatus.error:
                return Text(state.errorMessage);

              default:
                return _buildNotes(notes: state.noteList);
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddNote()),
          );
          await BlocProvider.of<NoteFetchCubit>(context).fetchAllNotes();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildNotes({required List<Note> notes}) => notes.isEmpty
      ? const Text("No Notes")
      : StaggeredGridView.countBuilder(
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
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NoteDetailPage(note: note),
                  ),
                );
                await BlocProvider.of<NoteFetchCubit>(context).fetchAllNotes();
              },
              child: NoteCardWidget(note: note, index: index),
            );
          },
        );
}
