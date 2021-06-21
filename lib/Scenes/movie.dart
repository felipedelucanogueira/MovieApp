import 'dart:core';

class Movie {
  List<MovieList> movies;

  Movie({this.movies});

  Movie.fromJson(Map<String, dynamic> json) {
    var arrayMovie = json['results'] as List;

    movies = arrayMovie.map((item) {
      return MovieList.fromJson(item);
    }).toList();
  }
}

class TopRatedMovie {
  List<TopRatedMovieList> ratedmovies;

  TopRatedMovie({this.ratedmovies});

  TopRatedMovie.fromJson(Map<String, dynamic> json) {
    var arrayTopRatedMovie = json['results'] as List;

    ratedmovies = arrayTopRatedMovie.map((item) {
      return TopRatedMovieList.fromJson(item);
    }).toList();
  }
}

class TopRatedMovieList {
  int id;
  String title;
  String poster_path;
  String release_date;
  String overview;
  num vote_average;

  TopRatedMovieList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    poster_path = json['poster_path'];
    release_date = json['release_date'];
    overview = json['overview'];
    vote_average = json['vote_average'];
  }
}

class MovieList {
  Future<List<MovieList>> movie;

  int id;
  String title;
  String poster_path;
  String release_date;
  String overview;
  num vote_average;

  MovieList({this.title, this.vote_average});

  MovieList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    poster_path = json['poster_path'];
    release_date = json['release_date'];
    overview = json['overview'];
    vote_average = json['vote_average'];
  }

  Map<String,dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'title': title,
      'poster_path': poster_path,
      'release_date': release_date,
      'overview': overview,
      'vote_average':vote_average
    };
    return map;
  }
}
