import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:zipaquira_2/infrastructure/models/local_news_model.dart';
import 'package:zipaquira_2/pages/news/full_news.dart';

import 'package:zipaquira_2/delegate/search_news_delegate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:zipaquira_2/shared/data/news_local_post.dart';
import 'package:zipaquira_2/shared/data/news_tourism_local_post.dart';
import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();

  late List newsObjectJson = jsonDecode(newsLocalPost) as List;
  late List<LocalNewsModel> newsList = newsObjectJson
      .map((newJson) => LocalNewsModel.fromJson(newJson))
      .toList();

  late List newsObjectTourismJson = jsonDecode(newsTourismLocalPost) as List;
  late List<LocalNewsModel> newsListTourism = newsObjectTourismJson
      .map((newJson) => LocalNewsModel.fromJson(newJson))
      .toList();

  List<LocalNewsModel> culturalList = [];
  List<LocalNewsModel> sportList = [];
  List<LocalNewsModel> tourismList = [];
  List<LocalNewsModel> trafficList = [];
  List<dynamic> itemList = [];

  List<LocalNewsModel> resultList = [];
  List<dynamic> listaNoticias = [];

  Future<List<LocalNewsModel>> fetchDetails() async {
    for (int i = 0; i < resultList.length; i++) {
      var url =
          Uri.parse("http://20.114.138.246/api/v2/news/${resultList[i].id}");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        resultList[i].type = jsonData['meta']['parent']['title'];
        resultList[i].description = jsonData['description'];
        resultList[i].body = utf8.decode(jsonData['body'].codeUnits);

        resultList[i].author = utf8.decode(jsonData['author'].codeUnits);

        String imageId = extractImageIdFromHtml(jsonData['body']);

        // Concatena la URL base con el ID de la imagen para obtener la URL completa
        String baseUrl = "http://20.114.138.246";
        String imageUrlApi = "/api/v2/images/$imageId";
        String fullImageUrl = baseUrl + imageUrlApi;

        var imageUrlResponse = await http.get(Uri.parse(fullImageUrl));
        if (imageUrlResponse.statusCode == 200) {
          Map<String, dynamic> imageJsonData =
              json.decode(imageUrlResponse.body);
          String imageUrl = baseUrl + imageJsonData['meta']['download_url'];

          resultList[i].imageUrl = imageUrl;
        }
      }
    }
    return resultList;
  }

  List<String> extractLinks(String text) {
    RegExp linkRegExp = RegExp(
      r"http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+",
      multiLine: true,
    );

    List<String> links =
        linkRegExp.allMatches(text).map((match) => match.group(0)!).toList();
    return links;
  }

// Método para extraer el ID de la imagen del contenido HTML
  String extractImageIdFromHtml(String htmlContent) {
    RegExp regex = RegExp(r'id="(\d+)"');

    Match? match = regex.firstMatch(htmlContent);

    if (match != null) {
      String id = match.group(1) ?? '';
      return id;
    } else {
      return '13';
    }
  }

  Future<List<dynamic>> fetchData() async {
    var url = Uri.parse("http://20.114.138.246/api/v2/news/?descendant_of=3");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);

      if (jsonData.containsKey('items')) {
        return jsonData['items'];
      } else {
        print('Error en la solicitud HTTP: ${response.statusCode}');
      }
    }
    return List.empty();
  }

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    // Convierte la cadena JSON en una lista de elementos

    fetchData().then((value) {
      setState(() {});
      listaNoticias = value;
      newsList =
          value.map((newJson) => LocalNewsModel.fromJson(newJson)).toList();
      resultList = newsList
          .where((element) => element.meta?.type == "noticias.Noticia")
          .toList();
      fetchDetails().then((value) {
        setState(() {});

        culturalList =
            resultList.where((element) => element.type == "CULTURAL").toList();
        sportList =
            resultList.where((element) => element.type == "DEPORTE").toList();
        tourismList =
            resultList.where((element) => element.type == "TURISMO").toList();
        trafficList =
            resultList.where((element) => element.type == "TRAFICO").toList();

        Future.delayed(Duration(seconds: 0), () {
          if (mounted) {
            setState(() {
              isLoading = false;
            });
          }
        });
      });
    });
    print(resultList);
  }

  @override
  Widget build(BuildContext context) {
    Color mygreen = Color(0xFFB8D432);
    late TabController _tabController = TabController(length: 5, vsync: this);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 225, 225, 225),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: isLoading
            ? Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Agrega la imagen
                      Image.asset(
                        'assets/escudo.jpg',
                        width: 400,
                        height: MediaQuery.of(context).size.height / 2,
                      ),
                      // Agrega el indicador de carga circular
                      SpinKitCircle(
                        color: Colors.green, // Color del círculo de carga
                        size: 400.0, // Tamaño del círculo de carga
                      ),
                    ],
                  ),
                ),
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 51),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Logo inicial
                    Container(
                      child: Center(
                        child: Image.asset(
                          'assets/logo_main.png',
                          fit: BoxFit.fitWidth,
                          width: 220,
                          height: 78,
                        ),
                      ),
                    ),
                    SizedBox(height: 25),

                    // Campo de búsqueda
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              decoration: InputDecoration(
                                hintText: 'Buscar...',
                                border: InputBorder.none,
                              ),
                              onChanged: (query) {
                                // Aquí puedes manejar la lógica de búsqueda cuando el texto cambia.
                                // Puedes usar el valor de 'query' para buscar y actualizar los resultados si es necesario.
                              },
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showSearch(
                                context: context,
                                delegate: SearchNewsDelegate(
                                    resultList, searchController.text),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.green,
                                shape: BoxShape.rectangle,
                              ),
                              child: Icon(
                                Icons.search_sharp,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),

                    // Tabbar
                    Container(
                      child: TabBar(
                        isScrollable: true,
                        controller: _tabController,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.black.withOpacity(0.8),
                        tabs: const [
                          Tab(
                            text: '#Todo',
                          ),
                          Tab(
                            text: '#Turismo',
                          ),
                          Tab(
                            text: '#Deportes',
                          ),
                          Tab(
                            text: '#Trafico',
                          ),
                          Tab(
                            text: '#Cultural',
                          ),
                        ],
                        labelStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                        indicatorColor: Colors.green,
                      ),
                    ),

                    SizedBox(height: 25),

                    // Todas las noticias
                    Container(
                      height: 250,
                      width: double.maxFinite,
                      child: TabBarView(controller: _tabController, children: [
                        ListView.builder(
                          itemCount: resultList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            var text = Text(
                              resultList[index].author!,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                              ),
                            );
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        FullNews(resultList[index])));
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.only(right: 10, top: 10),
                                width: 251,
                                height: 240,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                child: Stack(children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12, 12, 12, 90),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        resultList[index].imageUrl!,
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 20, top: 100),
                                      child: Text(
                                        resultList[index].title!,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 200),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            "assets/logo.jpg",
                                            width: 60,
                                            height: 50,
                                          ),
                                          SizedBox(width: 5),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              text,
                                              Text(
                                                resultList[index]
                                                    .getFormattedDate(),
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                          /*  SizedBox(width: 35),
                                          IconButton(
                                            alignment: Alignment.topRight,
                                            onPressed: () {
                                              // Lógica para compartir aquí
                                            },
                                            icon: Transform.rotate(
                                                angle:
                                                    -30 * 3.14159265359 / 180,
                                                child: Icon(Icons.send,
                                                    color: Colors.green,
                                                    size: 20)),
                                          ), */
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                            );
                          },
                        ),

                        //Turismo
                        ListView.builder(
                          itemCount: tourismList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            var text = Text(
                              tourismList[index].author!,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                              ),
                            );
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FullNews(tourismList[index])),
                                );
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.only(right: 10, top: 10),
                                width: 251,
                                height: 240,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                child: Stack(children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12, 12, 12, 90),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        tourismList[index].imageUrl!,
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 20, top: 100),
                                      child: Text(
                                        utf8.decode(utf8
                                            .encode(tourismList[index].title!)),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 200),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            "assets/logo.jpg",
                                            width: 60,
                                            height: 50,
                                          ),
                                          SizedBox(width: 5),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              text,
                                              Text(
                                                tourismList[index]
                                                    .getFormattedDate(),
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                          /* SizedBox(width: 35),
                                          IconButton(
                                            alignment: Alignment.topRight,
                                            onPressed: () {
                                              // Lógica para compartir aquí
                                            },
                                            icon: Transform.rotate(
                                                angle:
                                                    -30 * 3.14159265359 / 180,
                                                child: Icon(Icons.send,
                                                    color: Colors.green,
                                                    size: 20)),
                                          ), */
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                            );
                          },
                        ),

                        //  deportes

                        ListView.builder(
                          itemCount: sportList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            var text = Text(
                              sportList[index].author!,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                              ),
                            );

                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FullNews(sportList[index])),
                                );
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.only(right: 10, top: 10),
                                width: 250,
                                height: 240,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                child: Stack(children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12, 12, 12, 90),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        sportList[index].imageUrl!,
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 20, top: 100),
                                      child: Text(
                                        sportList[index].title!,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 200),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            "assets/logo.jpg",
                                            width: 60,
                                            height: 50,
                                          ),
                                          SizedBox(width: 5),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              text,
                                              Text(
                                                sportList[index]
                                                    .getFormattedDate(),
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                          /*  SizedBox(width: 35),
                                          IconButton(
                                            alignment: Alignment.topRight,
                                            onPressed: () {
                                              // Lógica para compartir aquí
                                            },
                                            icon: Transform.rotate(
                                                angle:
                                                    -30 * 3.14159265359 / 180,
                                                child: Icon(Icons.send,
                                                    color: Colors.green,
                                                    size: 20)),
                                          ), */
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                            );
                          },
                        ),
                        //  trafico

                        ListView.builder(
                          itemCount: trafficList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            var text = Text(
                              trafficList[index].author!,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                              ),
                            );
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FullNews(trafficList[index])),
                                );
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.only(right: 10, top: 10),
                                width: 250,
                                height: 240,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                child: Stack(children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12, 12, 12, 90),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        trafficList[index].imageUrl!,
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 20, top: 100),
                                      child: Text(
                                        trafficList[index].title!,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 200),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            "assets/logo.jpg",
                                            width: 60,
                                            height: 50,
                                          ),
                                          SizedBox(width: 5),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              text,
                                              Text(
                                                trafficList[index]
                                                    .getFormattedDate(),
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                          /* SizedBox(width: 35),
                                          IconButton(
                                            alignment: Alignment.topRight,
                                            onPressed: () {
                                              // Lógica para compartir aquí
                                            },
                                            icon: Transform.rotate(
                                                angle:
                                                    -30 * 3.14159265359 / 180,
                                                child: Icon(Icons.send,
                                                    color: Colors.green,
                                                    size: 20)),
                                          ), */
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                            );
                          },
                        ),
                        // Cultural

                        ListView.builder(
                          itemCount: culturalList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            var text = Text(
                              culturalList[index].author!,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                              ),
                            );
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FullNews(culturalList[index])),
                                );
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.only(right: 10, top: 10),
                                width: 250,
                                height: 240,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                child: Stack(children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12, 12, 12, 90),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        culturalList[index].imageUrl!,
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 20, top: 100),
                                      child: Text(
                                        culturalList[index].title!,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 200),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            "assets/logo.jpg",
                                            width: 60,
                                            height: 50,
                                          ),
                                          SizedBox(width: 5),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              text,
                                              Text(
                                                culturalList[index]
                                                    .getFormattedDate(),
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                          /* SizedBox(width: 35),
                                          IconButton(
                                            alignment: Alignment.topRight,
                                            onPressed: () {
                                              // Lógica para compartir aquí
                                            },
                                            icon: Transform.rotate(
                                                angle:
                                                    -30 * 3.14159265359 / 180,
                                                child: Icon(Icons.send,
                                                    color: Colors.green,
                                                    size: 20)),
                                          ), */
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                            );
                          },
                        ),
                      ]),
                    ),

                    SizedBox(height: 30),

                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Turismo para ti',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          /* Text(
                            'Ver todo',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: mygreen),
                          ), */
                        ],
                      ),
                    ),

                    SizedBox(height: 30),

                    // Tarjetas horizontales
                    Container(
                      height: 70,
                      width: double.maxFinite,
                      child: ListView.builder(
                        itemCount: tourismList.length, // Número de tarjetas
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                // Navegar a la pantalla FullNewsTourism cuando se toca la imagen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FullNews(tourismList[index])),
                                );
                              },
                              child: Container(
                                width: 250,
                                height: 115,
                                margin: EdgeInsets.only(
                                    right: 10), // Espacio entre elementos
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          tourismList[index].imageUrl!,
                                          fit: BoxFit.scaleDown,
                                          width: 140,
                                          height: 180,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            tourismList[index].title!,
                                            style: TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            tourismList[index]
                                                .getFormattedDate(),
                                            style: TextStyle(
                                              fontSize: 9,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
