import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:zipaquira_2/infrastructure/models/local_news_model.dart';

class FullNews extends StatefulWidget {
  final LocalNewsModel? localNewsInformation;

  const FullNews(this.localNewsInformation);

  @override
  State<FullNews> createState() => _FullNewsState();
}

class _FullNewsState extends State<FullNews> {
  late List<String> youtubeVideoIds;
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    youtubeVideoIds =
        extractYoutubeVideoIds(widget.localNewsInformation?.body ?? '');
    print('linea 24 $youtubeVideoIds');

    // Seleccionar el primer video de la lista o establecer una cadena predeterminada
    String initialVideoId = youtubeVideoIds.isNotEmpty ? youtubeVideoIds.first : 'TuVideoIdPredeterminado';

    // Iniciar el controlador de Youtube player
    _controller = YoutubePlayerController(
      initialVideoId: initialVideoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  List<String> extractYoutubeVideoIds(String body) {
    final RegExp regex = RegExp(
      r'https?:\/\/(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([^\s/"]+)',
    );
    final Iterable<RegExpMatch> matches = regex.allMatches(body);
    return matches.map((match) => match.group(1) ?? "").toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de la noticia (40% superior)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 420,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:
                      NetworkImage(widget.localNewsInformation?.imageUrl ?? ''),
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
          // Contenedor blanco con detalles de la noticia (60% inferior)
          Positioned(
            top: 330,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(55),
                  topRight: Radius.circular(55),
                ),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Título de la noticia
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        child: Text(
                          widget.localNewsInformation?.title ?? '',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Rectángulo con logo, ciudad y fecha
                      Container(
                        width: 320,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.2,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            // Logo pequeño
                            Image.asset(
                              "assets/logo.jpg",
                              width: 40,
                              height: 30,
                            ),
                            SizedBox(width: 10),
                            // Ciudad y fecha (mes abreviado y número del día)
                            Row(
                              children: [
                                Text(
                                  widget.localNewsInformation?.author ?? '',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  widget.localNewsInformation
                                          ?.getFormattedDate() ??
                                      '',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      // Texto de la noticia con margen
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 5),
                        child: Html(

                          data: widget.localNewsInformation?.body ?? '',
                          style: {
                            "body": Style(
                              fontSize: FontSize(20),
                              fontWeight: FontWeight.w400,
                            ),
                          },
                          onLinkTap: (url, renderContext, attributes, element) {
                            if (url != null && youtubeVideoIds.contains(url)) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  content: YoutubePlayer(
                                    controller: _controller,
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Cerrar'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Floating Action Button en la esquina superior izquierda con bordes blancos
          Positioned(
            top: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white,
                    width: 0.4,
                  ),
                ),
                child: FloatingActionButton(
                  backgroundColor: Colors.transparent,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
