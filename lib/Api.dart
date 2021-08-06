import 'package:http/http.dart'as http;
import 'dart:convert';
import 'package:youtube/model/Video.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final CHAVE_YOUTUBE_API = env['API_YOUTUBE'];
//const ID_CANAL = "UCVHFbqXqoYvEWM1Ddxl0QDg";
const URL_BASE = "https://www.googleapis.com/youtube/v3/";

class Api {
  Future<List<Video>>pesquisar(String pesquisa) async {

    http.Response response = await http.get(
      URL_BASE + "search"
          "?part=snippet"
          "&type=video"
          "&maxResults=20"
          "&order=date"
          "&key=$CHAVE_YOUTUBE_API"
          //"&channelId=$ID_CANAL" // Se quiser limitar a pesquisa a um canal
          "&q=$pesquisa"
    );

    if( response.statusCode == 200) {
      Map<String, dynamic> dadosJson = json.decode(response.body);

      List<Video> videos = dadosJson["items"].map<Video>(
              (map) {
            return Video.fromJson(map);
          }
      ).toList();

      return videos;
    }
  }
}

