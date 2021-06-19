import 'dart:async';
import 'dart:convert';
import 'package:movie_app/api/api.dart';
import 'package:movie_app/model/movie_model.dart';
import '../movie.dart';

class MovieViewModel {
  final model = MovieModel();


  StreamController<Movie> streamMovie = StreamController();
  StreamController<TopRatedMovie> streamTopRatedMovie = StreamController();

  Future<String> movieId(int id)  => model.getMovieId(id);
  List<MovieList> cachedMovie = [];

  List<TopRatedMovieList> cachedRatedMovie = [];

    saveFavorite() async{
      final json = cachedMovie.map((e) => (e.toMap())).toList();
      //await model.saveFavorite(json);
      await model.getMovieList();
    }

  loadMovie() {
    model.fetchMovie();
    model.movie.then((value) {
      streamMovie.add(value);
      cachedMovie = value.movies;
    });
  }

  updateList() {
    model.page++;
    model.fetchMovie();
    model.movie.then((value) {
      cachedMovie = [...cachedMovie, ...value.movies];
      streamMovie.add(Movie(movies: cachedMovie));
    });
  }

  updateRatedList() {
    model.ratedPage++;
    model.fetchRatedMovie();
    model.ratedMovie.then((value) {
      cachedRatedMovie = [...cachedRatedMovie, ...value.ratedmovies];
      streamTopRatedMovie.add(TopRatedMovie(ratedmovies: cachedRatedMovie));

    });
  }

  saveUser(int id , MovieList saveMovie){
    model.saveMovie(id ,saveMovie);
  }


  deleteMovie(int id){

    model.deleteMovie(id);
  }

  loadRatedMovie() {
    model.fetchRatedMovie();
    model.ratedMovie.then((value) {
      streamTopRatedMovie.add(value);
      cachedRatedMovie = value.ratedmovies;
    });
  }
}
