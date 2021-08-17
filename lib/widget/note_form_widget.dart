import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes_sqflite/cubit/cubit.dart';

import '../cubit/add_note_cubit/add_note_cubit.dart';

class NoteFormWidget extends StatelessWidget {
  const NoteFormWidget({
    Key? key,
    this.isImportant,
    this.number,
    this.title,
    this.description,
    required this.onChangedImportant,
    required this.onChangedNumber,
    required this.onChangedTitle,
    required this.onChangedDescription,
  }) : super(key: key);

  final bool? isImportant;
  final int? number;
  final String? title;
  final String? description;
  final ValueChanged<bool> onChangedImportant;
  final ValueChanged<int> onChangedNumber;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildTitle(),
            const SizedBox(height: 8),
            buildDescription(),
            const SizedBox(height: 16),
            // Slider(
            //   value: (number ?? 0).toDouble(),
            //   max: 5,
            //   divisions: 5,
            //   onChanged: (number) => onChangedNumber(number.toInt()),
            // ),
            if (isImportant == null)
              BlocBuilder<AddNoteCubit, AddNoteState>(
                builder: (context, state) {
                  return SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    value: state.isImp,
                    onChanged: onChangedImportant,
                    title: const Text("Is Important"),
                  );
                },
              )
            else
              BlocBuilder<EditNoteCubit, EditNoteState>(
                builder: (context, state) {
                  return SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    value: state.isImp == null ? isImportant! : state.isImp!,
                    onChanged: onChangedImportant,
                    title: const Text("Is Important"),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget buildTitle() => TextFormField(
        initialValue: title,
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Title',
          hintStyle: TextStyle(color: Colors.white70),
        ),
        textInputAction: TextInputAction.next,
        validator: (title) => title != null && title.isEmpty ? 'The title cannot be empty' : null,
        onChanged: onChangedTitle,
      );

  Widget buildDescription() => TextFormField(
        maxLines: 5,
        initialValue: description,
        style: const TextStyle(color: Colors.white60, fontSize: 18),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Type something...',
          hintStyle: TextStyle(color: Colors.white60),
        ),
        validator: (title) => title != null && title.isEmpty ? 'The description cannot be empty' : null,
        onChanged: onChangedDescription,
      );
}
