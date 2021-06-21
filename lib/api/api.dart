import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/model/movie_model.dart';
import '../Scenes/movie.dart';

class API {
  const API();

  Future<Movie> fetchMovie({int page = 0}) async {
    final response =
        await http.get(Uri.https('api.themoviedb.org', '/3/movie/upcoming', {
      'api_key': 'a5bc05fb630c9b7fdc560033345fa13e',
      'page': '$page',
      'language': 'pt-BR'
    }));

    if (response.statusCode == 200) {
      return Movie.fromJson(jsonDecode(response.body));
    } else {
      return Future.error('Movie Not Found');
    }
  }

  Future<TopRatedMovie> fetchRatedMovie({int ratedPage = 0}) async {
    final response =
        await http.get(Uri.https('api.themoviedb.org', '/3/movie/top_rated', {
      'api_key': 'a5bc05fb630c9b7fdc560033345fa13e',
      'page': '$ratedPage',
      'language': 'pt-br'
    }));

    if (response.statusCode == 200) {
      return TopRatedMovie.fromJson(jsonDecode(response.body));
    } else {
      return Future.error('Movie Not Found');
    }
  }
}
