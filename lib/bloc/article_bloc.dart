import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sports/data/models/api_result_model.dart';
import 'package:sports/data/repositories/article_repository.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleRepository repository;
  ArticleBloc({required this.repository}) : super(ArticleInitial()) {
    on<ArticleEvent>((event, emit) async {
      if (event is FetchArticlesEvent) {
        emit(ArticleLoadingState());
        try {
          List<Articles>? articles = await repository.getArticles();
          emit(ArticleLoadedState(articles: articles!));
        } catch (e) {
          emit(ArticleErrorState(message: e.toString()));
        }
      }
    });
  }
}
