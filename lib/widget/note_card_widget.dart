import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/notes_model.dart';

final _lightColors = [Colors.amber.shade300, Colors.lightGreen.shade300, Colors.lightBlue.shade300, Colors.orange.shade300, Colors.pinkAccent.shade100, Colors.tealAccent.shade100];

class NoteCardWidget extends StatelessWidget {
  const NoteCardWidget({
    Key? key,
    required this.note,
    required this.index,
  }) : super(key: key);

  final Note note;
  final int index;

  @override
  Widget build(BuildContext context) {
    /// Pick colors from the accent colors based on index
    // print("ModuloColor value : ${index % _lightColors.length}");
    // print("Widget height Index : ${index % 4}");
    final color = _lightColors[index % _lightColors.length];
    final time = DateFormat.yMMMd().format(note.createdTime);
    final minHeight = getMinHeight(index);

    return Card(
      color: color,
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    time,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                Icon(
                  note.isImportant ? Icons.label_important : null,
                  color: Colors.teal,
                ),
                Icon(
                  note.isFav ? Icons.favorite : null,
                  color: Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              note.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              note.description,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  /// To return different height for different widgets
  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 150;
      case 3:
        return 100;
      default:
        return 100;
    }
  }
}
