import 'package:flutter/material.dart';
import 'package:zipaquira_2/infrastructure/models/local_news_model.dart';

import '../pages/news/full_news.dart';

class SearchNewsDelegate extends SearchDelegate<LocalNewsModel> {
  final List<LocalNewsModel> resultList;
  final String initialQuery;

  SearchNewsDelegate(this.resultList, this.initialQuery) {
    query = initialQuery; 
  }

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
        close(context, LocalNewsModel()); // No pasa ningún valor si no se ha seleccionado un resultado
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredResults = _filterResults(resultList, query);
    
    return query.isEmpty ? Container() : _buildSearchResults(context, filteredResults);
  }

  @override
Widget buildSuggestions(BuildContext context) {
  final filteredResults = _filterResults(resultList, initialQuery);

  return initialQuery.isEmpty ? Container() : _buildSearchResults(context, filteredResults);
}

  List<LocalNewsModel> _filterResults(List<LocalNewsModel> allResults, String query) {
    return allResults.where((news) =>
        news.type != null &&
        news.title != null &&
        (news.type!.toLowerCase().contains(query.toLowerCase()) ||
            news.title!.toLowerCase().contains(query.toLowerCase()))).toList();
  }

  Widget _buildSearchResults(BuildContext context, List<LocalNewsModel> results) {
    if (results.isEmpty) {
      return Center(
        child: Text("No se encontraron resultados"),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final news = results[index];
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
