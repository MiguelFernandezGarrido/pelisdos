import 'dart:convert';

import 'package:http/http.dart';

class VideoService {
  final String urlBase = 'https://api.themoviedb.org/3/movie/';
  final String urlYoutube = 'https://www.youtube.com/watch?v=';
  final String urlEnd = '/videos';
  final String _apiKey = 'e1120ac6d9f51bd8ad5edaf015191f36';
  Future<String> getVideoId(int id) async {
    // return urlYoutube + 's9lHk5yZyZU';
    final response =
        await get(Uri.parse('$urlBase$id$urlEnd?api_key=$_apiKey'));
    final Map<String, dynamic> decodedData = json.decode(response.body);
    final List<dynamic> results = decodedData['results'];
    if (results.isEmpty) {
      return '';
    }
    return urlYoutube + (results[0]['key']);
  }
}
