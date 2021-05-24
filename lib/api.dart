import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/movie_model.dart';
import 'movie.dart';


class API{

const API();

  Future<Movie>fetchMovie() async {



    final response =
    await http.get(Uri.https('api.themoviedb.org', '/3/movie/upcoming',{'api_key': 'a5bc05fb630c9b7fdc560033345fa13e','page': '2','language':'pt-BR'}));

    if (response.statusCode == 200){
      return Movie.fromJson(jsonDecode(response.body));
    }else{
      return Future.error('Movie Not Found');

    }
    
  }

  Future<TopRatedMovie>fetchRatedMovie() async {

    final response = await http.get(Uri.https('api.themoviedb.org', '/3/movie/top_rated',{'api_key': 'a5bc05fb630c9b7fdc560033345fa13e','page':'3','language':'pt-br'}));

    if (response.statusCode == 200){
      return TopRatedMovie.fromJson(jsonDecode(response.body));
    }else{
      return Future.error('Movie Not Found');

    }

  }

  
  
}