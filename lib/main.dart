import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';
import 'screens/note_screen.dart';

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
