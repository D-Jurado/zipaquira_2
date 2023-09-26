import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:zipaquira_2/infrastructure/models/local_news_model.dart';
import 'package:zipaquira_2/pages/news/full_news.dart';
import 'package:zipaquira_2/pages/news/full_news_tourism.dart';
import 'package:zipaquira_2/shared/data/news_local_post.dart';
import 'package:zipaquira_2/shared/data/news_tourism_local_post.dart';




class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  TextEditingController _searchController = TextEditingController();

  late List newsObjectJson = jsonDecode(newsLocalPost) as List;
  late List<LocalNewsModel> newsList = newsObjectJson
      .map((newJson) => LocalNewsModel.fromJson(newJson))
      .toList();

  late List newsObjectTourismJson = jsonDecode(newsTourismLocalPost) as List;
  late List<LocalNewsModel> newsListTourism = newsObjectTourismJson
      .map((newJson) => LocalNewsModel.fromJson(newJson))
      .toList();

  List<LocalNewsModel> musicList = [];
  List<LocalNewsModel> sportList = [];
  List<LocalNewsModel> tourismList = [];
  List<LocalNewsModel> trafficList = [];

  @override
  void initState() {
    super.initState();

    // Convierte la cadena JSON en una lista de elementos
    List<dynamic> listaNoticias = jsonDecode(newsLocalPost);

    for (var noticiaJson in listaNoticias) {
      LocalNewsModel news =
          LocalNewsModel.fromJson(noticiaJson as Map<String, dynamic>);

      // Filtra las noticias en las listas correspondientes
      if (news.type == "music") {
        musicList.add(news);
      } else if (news.type == "sport") {
        sportList.add(news);
      } else if (news.type == "tourism") {
        tourismList.add(news);
      } else if (news.type == "traffic") {
        trafficList.add(news);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Color mygreen = Color(0xFFB8D432);
    late TabController _tabController = TabController(length: 4, vsync: this);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 51),
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
                      controller: _searchController,
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
                      // Maneja la acción de búsqueda aquí
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
                controller: _tabController,
                labelColor: Colors.grey,
                unselectedLabelColor: Colors.grey.withOpacity(0.8),
                tabs: const [
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
                    text: '#Musica',
                  )
                ],
                labelStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey),
                indicatorColor: Colors.green,
              ),
            ),

            SizedBox(height: 25),

            // Cuadro noticias
            Container(
              height: 250,
              width: double.maxFinite,
              child: TabBarView(controller: _tabController, children: [
                ListView.builder(
                  itemCount: newsList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    var text = Text(
                      newsList[index].city!,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    );
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => FullNews()),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10, top: 10),
                        width: 231,
                        height: 164,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Stack(children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12, 12, 12, 90),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                newsList[index].imageUrl!,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.only(left: 20, top: 100),
                              child: Text(
                                newsList[index].title!,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: const EdgeInsets.only(top: 200),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/logo.jpg",
                                    width: 50,
                                    height: 50,
                                  ),
                                  SizedBox(width: 5),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      text,
                                      Text(
                                        newsList[index].date!,
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 35),
                                  IconButton(
                                    alignment: Alignment.topRight,
                                    onPressed: () {
                                      // Lógica para compartir aquí
                                    },
                                    icon: Transform.rotate(
                                        angle: -30 * 3.14159265359 / 180,
                                        child: Icon(Icons.send,
                                            color: Colors.green, size: 20)),
                                  ),
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
                  itemCount: newsList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    var text = Text(
                      sportList[index].city!,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    );
                    
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => FullNews()),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10, top: 10),
                        width: 231,
                        height: 164,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Stack(children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12, 12, 12, 90),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                sportList[index].imageUrl!,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.only(left: 20, top: 100),
                              child: Text(
                                sportList[index].title!,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: const EdgeInsets.only(top: 200),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/logo.jpg",
                                    width: 50,
                                    height: 50,
                                  ),
                                  SizedBox(width: 5),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      text,
                                      Text(
                                        sportList[index].date!,
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 35),
                                  IconButton(
                                    alignment: Alignment.topRight,
                                    onPressed: () {
                                      // Lógica para compartir aquí
                                    },
                                    icon: Transform.rotate(
                                        angle: -30 * 3.14159265359 / 180,
                                        child: Icon(Icons.send,
                                            color: Colors.green, size: 20)),
                                  ),
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
                  itemCount: newsList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    var text = Text(
                      trafficList[index].city!,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    );
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => FullNews()),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10, top: 10),
                        width: 231,
                        height: 164,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Stack(children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12, 12, 12, 90),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                trafficList[index].imageUrl!,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.only(left: 20, top: 100),
                              child: Text(
                                trafficList[index].title!,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: const EdgeInsets.only(top: 200),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/logo.jpg",
                                    width: 50,
                                    height: 50,
                                  ),
                                  SizedBox(width: 5),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      text,
                                      Text(
                                        trafficList[index].date!,
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 35),
                                  IconButton(
                                    alignment: Alignment.topRight,
                                    onPressed: () {
                                      // Lógica para compartir aquí
                                    },
                                    icon: Transform.rotate(
                                        angle: -30 * 3.14159265359 / 180,
                                        child: Icon(Icons.send,
                                            color: Colors.green, size: 20)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                      ),
                    );
                  },
                ),
                // Musica

                ListView.builder(
                  itemCount: newsList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    var text = Text(
                      musicList[index].city!,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    );
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => FullNews()),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10, top: 10),
                        width: 231,
                        height: 164,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Stack(children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12, 12, 12, 90),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                musicList[index].imageUrl!,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.only(left: 20, top: 100),
                              child: Text(
                                musicList[index].title!,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: const EdgeInsets.only(top: 200),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/logo.jpg",
                                    width: 50,
                                    height: 50,
                                  ),
                                  SizedBox(width: 5),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      text,
                                      Text(
                                        musicList[index].date!,
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 35),
                                  IconButton(
                                    alignment: Alignment.topRight,
                                    onPressed: () {
                                      // Lógica para compartir aquí
                                    },
                                    icon: Transform.rotate(
                                        angle: -30 * 3.14159265359 / 180,
                                        child: Icon(Icons.send,
                                            color: Colors.green, size: 20)),
                                  ),
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
                  Text(
                    'Ver todo',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: mygreen),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            // Tarjetas horizontales
           Container(
  height: 70,
  width: double.maxFinite,
  child: ListView.builder(
    itemCount: newsListTourism.length, // Número de tarjetas
    scrollDirection: Axis.horizontal,
    itemBuilder: (BuildContext context, int index) {
      return GestureDetector(
        onTap: () {
          // Navegar a la pantalla FullNewsTourism cuando se toca la imagen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FullNewsTourim(),
            ),
          );
        },
        child: Container(
          width: 220,
          height: 105,
          margin: EdgeInsets.only(right: 10), // Espacio entre elementos
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    newsListTourism[index].imageUrl!,
                  ),
                ),
              ),
              SizedBox(width: 5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      newsListTourism[index].title!,
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      newsListTourism[index].date!,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    )
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
