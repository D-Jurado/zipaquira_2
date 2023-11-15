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
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();

    String youtubeVideoIds =
        extractYoutubeVideoId(widget.localNewsInformation?.body ?? '');
    print('linea 24 $youtubeVideoIds');

    if (youtubeVideoIds.isNotEmpty) {
      _controller = YoutubePlayerController(
        initialVideoId: youtubeVideoIds,
        flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: false,
          loop: false,
        ),
      );
    } else {
      // Si no se encuentra un ID de video de YouTube, puedes realizar alguna acción o simplemente dejar _controller como nulo.
      print('No se encontró un ID de video de YouTube.');
    }
  }

  String extractYoutubeVideoId(String body) {
    final RegExp regex = RegExp(
      r'https?:\/\/(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([^\s/"]+)',
    );
    final Iterable<RegExpMatch> matches = regex.allMatches(body);
    return matches.isNotEmpty ? matches.first.group(1) ?? '' : '';
  }

  @override
  Widget build(BuildContext context) {
    String youtubeVideoIds =
        extractYoutubeVideoId(widget.localNewsInformation?.body ?? '');

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
                  image: NetworkImage(widget.localNewsInformation?.imageUrl ?? ''),
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
                                  widget.localNewsInformation?.getFormattedDate() ?? '',
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
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 5),
                        child: Html(
                          data: widget.localNewsInformation?.body ?? '',
                          style: {
                            "body": Style(
                              fontSize: FontSize(20),
                              fontWeight: FontWeight.w400,
                            ),
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      // Sección del video de Youtube (con condición)
                      if (youtubeVideoIds.isNotEmpty)
                        Positioned(
                          top: 10,
                          left: 0,
                          right: 0,
                          child: YoutubePlayerBuilder(
                            player: YoutubePlayer(
                              controller: _controller!,
                              showVideoProgressIndicator: true,
                              progressIndicatorColor: Colors.amber,
                              progressColors: ProgressBarColors(
                                playedColor: Colors.amber,
                                handleColor: Colors.amberAccent,
                              ),
                            ),
                            builder: (context, player) {
                              return Container(
                                child: player,
                              );
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
