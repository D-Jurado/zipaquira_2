import 'package:flutter/material.dart';
import 'package:zipaquira_2/infrastructure/models/local_news_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../shared/data/news_local_post.dart';

class NewsProvider extends ChangeNotifier {
  bool initialLoading = true;
  List<LocalNewsModel> newsTitle = [];
  List<LocalNewsModel> resultList = [];
  List<dynamic> listaNoticias = [];

  Future<void> fetchData() async {
    var url = Uri.parse("http://192.168.1.5:8000/api/v2/news/?descendant_of=4");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);

      if (jsonData.containsKey('items')) {
        listaNoticias = jsonData['items'];
        newsList = listaNoticias
            .map((newJson) => LocalNewsModel.fromJson(newJson))
            .toList();
        resultList = newsList
            .where((element) => element.meta?.type == "noticias.Noticia")
            .toList();
        notifyListeners(); 
      } else {
        print('Error en la solicitud HTTP: ${response.statusCode}');
      }
      
    }
    
  }
  
  List newsObjectJson = jsonDecode(newsLocalPost) as List;
  List<LocalNewsModel> newsList = [];

  NewsProvider() {
    fetchData(); 
  }
}
