import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sports/Screens/widgets/brief_description.dart';
import 'package:sports/Screens/widgets/thumbnail_image.dart';
import 'package:sports/bloc/article_bloc.dart';
import 'package:sports/data/models/api_result_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ArticleBloc articleBloc = BlocProvider.of<ArticleBloc>(context);
    articleBloc.add(FetchArticlesEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text("News"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              articleBloc.add(FetchArticlesEvent());
            },
          ),
        ],
      ),
      body: BlocListener<ArticleBloc, ArticleState>(
        listener: (context, state) {
          if (state is ArticleErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        child: BlocBuilder<ArticleBloc, ArticleState>(
          builder: (context, state) {
            if (state is ArticleInitial) {
              return buildLoading();
            } else if (state is ArticleLoadingState) {
              return buildLoading();
            } else if (state is ArticleLoadedState) {
              return buildArticleList(state.articles, context);
            } else if (state is ArticleErrorState) {
              return buildErrorUi(state.message);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget buildArticleList(List<Articles> articles, BuildContext context) {
    return ListView.builder(
        itemCount: articles.length,
        itemBuilder: ((context, pos) {
          return Container(
            height: 120.0,
            margin: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 16.0,
            ),
            child: InkWell(
              onTap: () {
                articleDetailPage(context, articles[pos]);
              },
              child: Stack(
                children: [
                  BriefDescription(
                    title: articles[pos].title.toString(),
                    publishedAt: articles[pos].publishedAt.toString(),
                    position: pos,
                  ),
                  ThumbnailImage(
                      urlToImage: articles[pos].urlToImage.toString()),
                ],
              ),
            ),
          );
        }));
  }

 
  articleDetailPage(BuildContext context, Articles article) {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
        elevation: 15.0,
        //backgroundColor: Colors.red,
        context: context,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.7,
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0, left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  //Source name of News
                  Center(
                    child: Text(
                      article.source!.name.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  //Image
                  (article.urlToImage.toString() != 'null')
                      ? Image.network(article.urlToImage.toString())
                      : Image.network(
                          'https://wellesleysocietyofartists.org/wp-content/uploads/2015/11/image-not-found.jpg',
                          height: 250,
                        ),

                  //Title
                  Text(
                    article.title.toString(),
                    style: const TextStyle(
                      color: Color.fromARGB(221, 255, 0, 0),
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(article.publishedAt.toString()),
                  const SizedBox(height: 15),
                  Text(
                    article.description.toString(),
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 44, 41, 41),
                      fontSize: 16,
                    ),
                  ),

                  // Image.network(article.urlToImage.toString()),
                  // Container(
                  //   alignment: Alignment.center,
                  //   padding: const EdgeInsets.all(10.0),
                  //   child: Text(
                  //     article.title.toString(),
                  //     style: const TextStyle(fontSize: 20.0),
                  //   ),
                  // ),
                  // Container(
                  //   alignment: Alignment.topRight,
                  //   margin: const EdgeInsets.all(5.0),
                  //   child: Text(article.publishedAt.toString()),
                  // ),
                  // Text(article.content.toString()),
                ],
              ),
            ),
          );
        });
  }
}
