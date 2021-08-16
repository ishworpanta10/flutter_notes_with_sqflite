import 'package:flutter/material.dart';

import 'screens/note_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Notes App',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      home: NotesScreen(),
    );
  }
}
