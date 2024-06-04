import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/bloc/todo/bloc/todo_bloc.dart';
import 'package:flutter_todo_bloc/domain/database_service.dart';
import 'package:flutter_todo_bloc/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => DatabaseService(),
      child: BlocProvider(
        create: (context) =>
            TodoBloc(RepositoryProvider.of(context))..add(LoadTodosEvent()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const HomePage(),
        ),
      ),
    );
  }
}


// RepositoryProvider(
//       create: (context) => DatabaseService(),
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: HomePage(),
//       ),
//     );