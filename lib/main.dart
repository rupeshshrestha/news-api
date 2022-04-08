import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sports/bloc/article_bloc.dart';
import 'package:sports/data/repositories/article_repository.dart';
import 'package:sports/home_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => ArticleBloc(repository: ArticleRepositoryImpl()),
        child: const HomePage(),
      ),
    );
  }
}
