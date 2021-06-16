import 'dart:async';

import 'package:movie_app/api/api.dart';
import 'package:movie_app/model/movie_model.dart';
import '../movie.dart';

class MovieViewModel {
  final model = MovieModel();

  // set page(int page) => model.page = page;
  // int get page => model.page;

  StreamController<Movie> streamMovie = StreamController();
  StreamController<TopRatedMovie> streamTopRatedMovie = StreamController();

  List<MovieList> cachedMovie = [];
  List<TopRatedMovieList> cachedRatedMovie = [];

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
    model.fetchRatedMovie();
    model.ratedPage++;
    model.ratedMovie.then((value) {
      cachedRatedMovie = [...cachedRatedMovie, ...value.ratedmovies];
      streamTopRatedMovie.add(TopRatedMovie(ratedmovies: cachedRatedMovie));

    });
  }

  loadRatedMovie() {
    model.fetchRatedMovie();
    model.ratedMovie.then((value) {
      streamTopRatedMovie.add(value);
    });
  }
}
