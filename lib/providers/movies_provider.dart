// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/movie.dart';
import 'package:peliculas/models/now_playing_response.dart';
import 'package:peliculas/service/favourites_service.dart';
import 'package:peliculas/shared_prefs/user_prefs.dart';
import 'dart:convert';

import '../models/cast.dart';
import '../models/credits_response.dart';
import '../models/popular_response.dart';
import '../models/search_movie_response.dart';
import '../models/top_rated_response.dart';
import '../models/upcoming_response.dart';

class MoviesProvider extends ChangeNotifier {
  final String _urlBase = 'api.themoviedb.org';
  final String _apiKey = 'e1120ac6d9f51bd8ad5edaf015191f36';
  final String _language = 'es-ES';
  int _popularPage = 0;
  int _topRatedPage = 0;
  int _upcomingPage = 0;

  List<Movie> enCines = [];
  List<Movie> populares = [];
  List<Movie> topRated = [];
  List<Movie> upcoming = [];
  // New
  List<Movie> favourites = [];
  FavouritesService favouritesService = FavouritesService();

  Map<int, List<Cast>> moviesCast = {};

  String? get lastPage {
    return UserPrefs.lastPageG;
  }

  set lastPage(String? page) {
    UserPrefs.lastPage = page!;
  }

  MoviesProvider() {
    _load();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) {
      return moviesCast[movieId]!;
    }
    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final cast = CreditsResponse.fromJson(jsonData).cast;
    moviesCast[movieId] = cast;
    return cast;
  }

  List<String> getLastSearches() {
    return UserPrefs.getLastSearches();
  }

  Future<Map<String, dynamic>> _getJsonData(String endpoint,
      [int page = 1]) async {
    var url = Uri.https(_urlBase, endpoint,
        {'api_key': _apiKey, 'language': _language, 'page': '$page'});
    final response = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(response.body);
    return decodedData;
  }

  Future<List<Movie>> searchMovies(String query) async {
    var url = Uri.https(_urlBase, '3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});
    final response = await http.get(url);
    final Map<String, dynamic> jsonData = json.decode(response.body);
    final searchResponse = SearchMovieResponse.fromJson(jsonData);
    return searchResponse.results;
  }

  Future<List<Movie>> searchMoviesYear(String query) async {
    var url = Uri.https(_urlBase, '3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});
    final response = await http.get(url);
    final Map<String, dynamic> jsonData = json.decode(response.body);
    final searchResponse = SearchMovieResponse.fromJson(jsonData);
    searchResponse.results
        .sort((a, b) => a.releaseDate!.compareTo(b.releaseDate!));
    return searchResponse.results;
  }

  getEnCinesMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    enCines = nowPlayingResponse.movies;
    enCines.forEach((movie) {
      favourites.forEach(
          (fav) => {if (movie.id == fav.id) movie.firebaseId = fav.firebaseId});
    });
    notifyListeners();
  }

  getPopulares() async {
    _popularPage++;
    final jsonData = await _getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);
    populares = populares + popularResponse.movies;
    populares.forEach((movie) {
      favourites.forEach(
          (fav) => {if (movie.id == fav.id) movie.firebaseId = fav.firebaseId});
    });
    notifyListeners();
  }

  getTopRated() async {
    _topRatedPage++;
    final jsonData = await _getJsonData('3/movie/top_rated', _topRatedPage);
    final topRatedResponse = TopRatedResponse.fromJson(jsonData);
    topRated = topRated + topRatedResponse.movies;
    topRated.forEach((movie) {
      favourites.forEach(
          (fav) => {if (movie.id == fav.id) movie.firebaseId = fav.firebaseId});
    });
    notifyListeners();
  }

  getUpcoming() async {
    _upcomingPage++;
    final jsonData = await _getJsonData('3/movie/upcoming', _upcomingPage);
    final upcomingResponse = UpcomingResponse.fromJson(jsonData);
    upcoming = upcoming + upcomingResponse.movies;
    upcoming.forEach((movie) {
      favourites.forEach(
          (fav) => {if (movie.id == fav.id) movie.firebaseId = fav.firebaseId});
    });
    notifyListeners();
  }

  void changeFavourite(Movie movie) async {
    // if (favourites.contains(movie)) {
    //   favourites.remove(movie);
    //   await favouritesService.deleteFavourite(movie);
    // } else {
    //   await favouritesService.saveFavourite(movie);
    //   favourites.add(movie);
    // }
    Movie movieTemp =
        favourites.firstWhere((element) => element.id == movie.id, orElse: () {
      return Movie.empty();
    });
    if (movieTemp.id != -1) {
      favourites.remove(movieTemp);
      await favouritesService.deleteFavourite(movie);
    } else {
      await favouritesService.saveFavourite(movie);
      favourites.add(movie);
    }
    notifyListeners();
  }

  _load() async {
    favourites = await favouritesService.getFavourites();
    getEnCinesMovies();
    getPopulares();
    getTopRated();
    getUpcoming();
    notifyListeners();
  }
}
