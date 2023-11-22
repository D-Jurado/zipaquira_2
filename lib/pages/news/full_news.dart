import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:zipaquira_2/infrastructure/models/local_news_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';

class FullNews extends StatefulWidget {
  final LocalNewsModel? localNewsInformation;

  const FullNews(this.localNewsInformation);

  @override
  State<FullNews> createState() => _FullNewsState();
}

class _FullNewsState extends State<FullNews> {
  YoutubePlayerController? _controller;

  List<String> downloadUrls = [];
  bool isLoading = true;
  String baseUrl = "http://20.114.138.246";

  int currentImageIndex = 0;

  @override
  void initState() {
    super.initState();

    String youtubeVideoIds =
        extractYoutubeVideoId(widget.localNewsInformation?.body ?? '');

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
      print('No se encontró un ID de video de YouTube.');
    }

    List<String> imageUrlsAndIds =
        extractImageUrlsAndIdsFromHtml(widget.localNewsInformation?.body ?? '');

    List<String> imageIds = imageUrlsAndIds
        .map((imageUrlAndId) =>
            RegExp(r'id="(\d+)"').firstMatch(imageUrlAndId)?.group(1) ?? '')
        .toList();

    fetchImageInfo(imageIds);
  }

  String extractYoutubeVideoId(String body) {
    final RegExp regex = RegExp(
      r'https?:\/\/(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([^\s/"]+)',
    );
    final Iterable<RegExpMatch> matches = regex.allMatches(body);
    return matches.isNotEmpty ? matches.first.group(1) ?? '' : '';
  }

  List<String> extractImageUrlsAndIdsFromHtml(String htmlContent) {
    List<String> imageUrlsAndIds = [];
    RegExp regex = RegExp(r'<embed[^>]+id="(\d+)"[^>]+>');
    Iterable<Match> matches = regex.allMatches(htmlContent);
    for (Match match in matches) {
      String imageUrlAndId = match.group(0) ?? '';
      imageUrlsAndIds.add(imageUrlAndId);
    }
    return imageUrlsAndIds;
  }

  Future<void> fetchImageInfo(List<String> imageIds) async {
    for (String imageId in imageIds) {
      try {
        var imageUrlResponse =
            await http.get(Uri.parse("$baseUrl/api/v2/images/$imageId"));

        if (imageUrlResponse.statusCode == 200) {
          Map<String, dynamic> imageJsonData =
              json.decode(imageUrlResponse.body);

          String downloadUrl = imageJsonData['meta']['download_url'];

          downloadUrls.add('$baseUrl$downloadUrl');

          print('Image Info for $imageId: $downloadUrl');
        } else {
          print(
              'Failed to fetch image info for $imageId. Status code: ${imageUrlResponse.statusCode}');
        }
      } catch (e) {
        print('Error fetching image info for $imageId: $e');
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.green,
          ),
        ),
      );
    }

    String youtubeVideoIds =
        extractYoutubeVideoId(widget.localNewsInformation?.body ?? '');

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 420,
            child: Container(
              decoration: BoxDecoration(
                image: downloadUrls.isNotEmpty
                    ? DecorationImage(
                        image: Image.network(downloadUrls[currentImageIndex])
                            .image,
                        fit: BoxFit.scaleDown,
                      )
                    : null,
              ),
            ),
          ),
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
                            Image.asset(
                              "assets/logo.jpg",
                              width: 40,
                              height: 30,
                            ),
                            SizedBox(width: 10),
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
                      SizedBox(height: 15),
                      if (downloadUrls.length > 1)
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          height: 420,
                          child: CarouselSlider(
                            items: downloadUrls
                                .map(
                                  (downloadUrl) => Image.network(
                                    downloadUrl,
                                    fit: BoxFit.cover,
                                  ),
                                )
                                .toList(),
                            options: CarouselOptions(
                              height: 100.0,
                              enlargeCenterPage: true,
                              autoPlay: false,
                              aspectRatio: 16 / 9,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enableInfiniteScroll: true,
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
                              viewportFraction: 0.5,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  currentImageIndex = index;
                                });
                              },
                            ),
                          ),
                        ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Html(
                          data: widget.localNewsInformation?.body ?? '',
                          onLinkTap: (url, context, attributes, element) {
                            _launchUrl(url);
                          },
                          style: {
                            "body": Style(
                              fontSize: FontSize(20),
                              fontWeight: FontWeight.w400,
                            ),
                          },
                        ),
                      ),
                      SizedBox(height: 30),
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

  Future<void> _launchUrl(String? url) async {
    if (url != null) {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        print('No se pudo abrir el enlace: $url');
      }
    }
  }
}
