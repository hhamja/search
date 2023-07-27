import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/bloc/auto_complete_cubit.dart';
import 'package:search/data/client/auto_complete_client.dart';
import 'package:search/data/repository/auto_complete_repository.dart';
import 'package:search/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AutoCompleteRepository(AutoCompleteClient()),
      child: BlocProvider<AutoCompleteCubit>(
        create: (context) => AutoCompleteCubit(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(useMaterial3: true),
          home: const HomePage(),
        ),
      ),
    );
  }
}
