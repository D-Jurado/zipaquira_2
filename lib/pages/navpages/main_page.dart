import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zipaquira_2/domain/entities/news_post.dart';
import 'package:zipaquira_2/infrastructure/models/local_news_model.dart';
import 'package:zipaquira_2/shared/data/news_local_post.dart';

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
  
    
  
  

  @override
  Widget build(BuildContext context) {
    Color mygreen = Color(0xFFB8D432);
    late TabController _tabController = TabController(length: 4, vsync: this);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 71),
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
                tabs: [
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
                    return Container(
                      margin: EdgeInsets.only(right: 10, top: 10),
                      width: 231,
                      height: 164,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Stack(children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(12, 12, 12, 90),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(newsList[index].imageUrl!),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 20, top: 100),
                            child: Text(
                              newsList[index].title!,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.only(top: 200),
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
                    );
                  },
                ),
                Text('Deportes'),
                Text('Trafico'),
                Text('Musica')
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
              height: 42,
              width: double.maxFinite,
              child: ListView.builder(
                itemCount: 4, // Número de tarjetas
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: 200,
                    height: 100,
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
                                'assets/welcome.jpg',
                              )),
                        ),
                        SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Titulo noticia',
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Fecha de la Noticia',
                              style: TextStyle(
                                fontSize: 8,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
