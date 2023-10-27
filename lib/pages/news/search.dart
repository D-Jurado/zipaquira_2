import 'package:flutter/material.dart';
import 'package:zipaquira_2/infrastructure/models/local_news_model.dart';
import 'package:flutter_html/flutter_html.dart';





class SearchPage extends StatefulWidget {
  final LocalNewsModel? localNewsInformation;
  const SearchPage(this.localNewsInformation);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}