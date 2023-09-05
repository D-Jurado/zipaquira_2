import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  TextEditingController _searchController = TextEditingController();
  // Aquí puedes definir una lista de resultados de búsqueda si es necesario.

  @override
  Widget build(BuildContext context) {
    late TabController _tabController = TabController(length: 4, vsync: this);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 71),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //logo inicial
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
            SizedBox(height: 38),

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
            ), // boton de buscar
            SizedBox(height: 38),

            //tabbar
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
            Container(
              height: 300,
              width: double.maxFinite,
              child: TabBarView(controller: _tabController, children: [
                ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(right:  10, top: 10),
                      width: 231,
                      height: 164,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(12, 12, 12, 128),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset('assets/noticia1.png'),
                            
                          ),
                          
                          
                          ),
                          
                          
                    );
                  },
                ),
                Text('Deportes'),
                Text('Trafico'),
                Text('Musica')
              ]),
            )
          ],
        ),
      ),
    );
  }
}
