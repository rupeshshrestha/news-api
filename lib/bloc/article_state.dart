part of 'article_bloc.dart';

@immutable
abstract class ArticleState {}

class ArticleInitial extends ArticleState {}

class ArticleLoadingState extends ArticleState {}

// ignore: must_be_immutable
class ArticleLoadedState extends ArticleState {
  List<Articles> articles;
  ArticleLoadedState({required this.articles});
}

// ignore: must_be_immutable
class ArticleErrorState extends ArticleState {
  String message;
  ArticleErrorState({required this.message});
}
