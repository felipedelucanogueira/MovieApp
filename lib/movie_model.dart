import 'package:movie_app/api.dart';
import 'movie.dart';

class MovieModel{

  Future<Movie> _movie;
  Future<Movie> get movie =>_movie;

  Future<TopRatedMovie> _ratedMovie;
  Future<TopRatedMovie> get ratedMovie => _ratedMovie;

  final API api;

  MovieModel({this.api = const API()});



  fetchMovie(){
    _movie = api.fetchMovie();


  }
  fetchRatedMovie(){
    _ratedMovie = API().fetchRatedMovie();


  }

}