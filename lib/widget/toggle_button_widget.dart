import 'package:flutter/material.dart';

class IconToggleButton extends StatelessWidget {
  const IconToggleButton({required this.isSelected, required this.onPressed});
  final bool isSelected;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 30,
      padding: const EdgeInsets.all(5),
      icon: isSelected == true
          ? const Icon(
              Icons.favorite_outlined,
              color: Colors.red,
            )
          : const Icon(Icons.favorite_border),
      onPressed: () {
        onPressed();
      },
    );
  }
}
