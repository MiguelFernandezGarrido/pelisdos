import 'dart:convert';
import 'package:http/http.dart';

import '../models/movie.dart';

class FavouritesService {
  String urlFav =
      'https://peliculasfavourites-default-rtdb.firebaseio.com/favs';

  Future<List<Movie>> getFavourites() async {
    Response response = await get(Uri.parse('$urlFav.json'));
    if (response.body == 'null') return [];

    Map<String, dynamic> data = jsonDecode(response.body);
    List<Movie> favs = [];

    data.forEach((firebaseId, movie) {
      Movie movieTemp = Movie.fromJson(movie);
      movieTemp.firebaseId = firebaseId;
      favs.add(movieTemp);
    });
    return favs;
  }

  Future<void> deleteFavourite(Movie movie) async {
    await delete(
      Uri.parse('$urlFav/${movie.firebaseId}.json'),
    );
    movie.firebaseId = null;
  }

  Future<void> saveFavourite(Movie movie) async {
    Response response =
        await post(Uri.parse('$urlFav.json'), body: jsonEncode(movie.toJson()));
    Map<String, dynamic> data = jsonDecode(response.body);
    movie.firebaseId = data.values.first;
  }
}
