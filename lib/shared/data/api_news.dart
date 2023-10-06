import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiNews extends StatefulWidget {
  const ApiNews({Key? key}) : super(key: key);

  @override
  State<ApiNews> createState() => _ApiNewsState();
}

class _ApiNewsState extends State<ApiNews> {
  List<String> listApiNews = [];

  @override
  void initState() {
    super.initState();
    fetchData(); // Llamar a la función de solicitud cuando se inicializa el widget
  }

  Future<void> fetchData() async {
    var url = Uri.parse("http://192.168.1.5:8000/api/v2/news/?descendant_of=4");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);

      if (jsonData.containsKey('items')) {
        List<dynamic> itemList = jsonData['items'];

        for (var item in itemList) {
          if (item.containsKey('title')) {
            String title = item['title'];
            // Verificar si el título contiene al menos una letra en minúscula
            if (title != title.toUpperCase()) {
              setState(() {
                listApiNews.add(title);
              });
            }
          }
        }
      }
    } else {
      print('Error en la solicitud HTTP: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Noticias'),
      ),
      body: ListView.builder(
        itemCount: listApiNews.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(listApiNews[index]),
          );
        },
      ),
    );
  }
}
