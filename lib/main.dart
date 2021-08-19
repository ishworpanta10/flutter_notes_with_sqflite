import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes_sqflite/screens/note_screen.dart';

import 'cubit/cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NoteFetchCubit>(
          create: (_) => NoteFetchCubit(),
        ),
        BlocProvider<AddNoteCubit>(
          create: (_) => AddNoteCubit(),
        ),
        BlocProvider<EditNoteCubit>(
          create: (_) => EditNoteCubit(
            noteFetchCubit: NoteFetchCubit(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Notes App',
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark(),
        home: NotesScreen(),
      ),
    );
  }
}
/*

class Home extends InheritedWidget {
  const Home({required Widget child, required this.dataToAccess}) : super(child: child);

  final String dataToAccess;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static Home? of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<Home>();
}

//method to access
   // final data = context.dependOnInheritedWidgetOfExactType<Home>()!.dataToAccess;
    // print("Data from inherited Widget $data");
    // final data = Home.of(context)!.dataToAccess;
    // print("data $data");
*/
