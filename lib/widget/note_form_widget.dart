import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes_sqflite/cubit/cubit.dart';
import 'package:flutter_notes_sqflite/widget/toggle_button_widget.dart';

import '../cubit/add_note_cubit/add_note_cubit.dart';

class NoteFormWidget extends StatelessWidget {
  const NoteFormWidget({
    Key? key,
    this.isImportant,
    this.isFav,
    this.number,
    this.title,
    this.description,
    required this.onChangedImportant,
    required this.onChangedFav,
    required this.onChangedNumber,
    required this.onChangedTitle,
    required this.onChangedDescription,
  }) : super(key: key);

  final bool? isImportant;
  final bool? isFav;
  final int? number;
  final String? title;
  final String? description;
  final ValueChanged<bool> onChangedImportant;
  final ValueChanged<bool> onChangedFav;
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
            //Adding first time we have inImp as null
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
              //Updating so we pass value
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
            if (isFav == null)
              //Adding
              BlocBuilder<AddNoteCubit, AddNoteState>(
                builder: (context, state) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text("Favourite"),
                    trailing: IconButton(
                      icon: state.isFav
                          ? const Icon(
                              Icons.favorite_outlined,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.favorite_border,
                            ),
                      onPressed: () {
                        context.read<AddNoteCubit>().favToggle(isFav: !state.isFav);
                      },
                    ),
                  );
                },
              )
            else
              //updating
              BlocBuilder<EditNoteCubit, EditNoteState>(
                builder: (context, state) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text("Favourite"),
                    trailing: IconToggleButton(
                      isSelected: state.isFav == null ? isFav! : state.isFav!,
                      onPressed: () {
                        context.read<EditNoteCubit>().favToggle(isFav: state.isFav == null ? !isFav! : !state.isFav!);
                        // print("After btn press isFva ${state.isFav}");
                      },
                    ),
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
