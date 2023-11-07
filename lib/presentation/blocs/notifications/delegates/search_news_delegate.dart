import 'package:flutter/material.dart';
import 'package:zipaquira_2/infrastructure/models/local_news_model.dart';

import '../../../../pages/news/full_news.dart';

class SearchNewsDelegate extends SearchDelegate<LocalNewsModel> {
  final List<LocalNewsModel> resultList;

  SearchNewsDelegate(this.resultList);

  @override
  String get searchFieldLabel => 'Buscar Noticia';
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context,
            LocalNewsModel()); // No pasa ningún valor si no se ha seleccionado un resultado
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return query.isEmpty ? Container() : _buildSearchResults(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return query.isEmpty ? Container() : _buildSearchResults(query);
  }

  Widget _buildSearchResults(String query) {
    final results = resultList.where((news) =>
        news.type != null &&
        news.title != null &&
        (news.type!.toLowerCase().contains(query.toLowerCase()) ||
            news.title!.toLowerCase().contains(query.toLowerCase())));

    if (results.isEmpty) {
      return Center(
        child: Text("No se encontraron resultados"),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final news = results.elementAt(index);
        return ListTile(
          title: Text(news.title!),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => FullNews(news),
              ),
            );
          },
        );
      },
    );
  }
}
