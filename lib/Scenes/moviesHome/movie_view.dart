import 'package:flutter/material.dart';
import 'package:movie_app/Scenes/moviesHome/movieViewModel.dart';
import 'package:movie_app/Scenes/MovieDetails/movie_details_view.dart';
import 'package:movie_app/Scenes/MovieDetails/top_rated_movies_details_view.dart';
import 'package:movie_app/api/api.dart';

import '../movie.dart';

class MovieView extends StatefulWidget {
  @override
  _MovieViewState createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  final controller = MovieViewModel();

  var _listController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.loadMovie();

    _listController.addListener(() {
      final pixel = _listController.position.pixels;

      if (pixel == _listController.position.maxScrollExtent) {
        controller.updateList();

        // if (_listController.position.atEdge) {
        //   if (_listController.position.pixels == 0) {
        //
        //   } else {
        //      model.page +=1;
        //      controller.updateList();
        //     // print('chegou a  o final');
        //     // print(model.page);
        //   }
        // }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Movie>(
      stream: controller.streamMovie.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.active) {
          return Center(
            child: Container(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                )),
          );
        }
        if (snapshot.hasError) {
          return Material(
            color: Colors.black,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'OPS....Falha ao carregar',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Container(
                      decoration: BoxDecoration(),
                      child: CircleAvatar(
                          radius: 100,
                          backgroundImage: NetworkImage(
                              'https://i.pinimg.com/originals/c5/f0/a4/c5f0a40e2e509e67730eb5d6edcb5d38.gif'))),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                    onPressed: () {
                      controller.loadMovie();
                    },
                    child: Text(
                      'Tentar Novamente',
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
          );
        }

        if (snapshot.hasData) {
          return Material(
            color: Colors.black,
            child: SafeArea(
              child: SingleChildScrollView(
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (overScroll) {
                    overScroll.disallowGlow();
                    return;
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hey Felipe',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                                textAlign: TextAlign.left,
                              ),
                              Divider(),
                              Text(
                                'Today , 24 February',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w100,
                                    fontSize: 15),
                              )
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                          ),
                          CircleAvatar(
                            radius: 25,
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Row(
                        children: [
                          Text(
                            '     EM BREVE',
                            style: TextStyle(color: Colors.white),
                          ),
                          Divider()
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.5,
                        padding: EdgeInsets.only(top: 15),
                        child: ListView.separated(
                            controller: _listController,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            separatorBuilder: (context, index) =>
                                VerticalDivider(
                                  width: 20,
                                ),
                            itemCount: snapshot.data.movies.length,
                            itemBuilder: (context, index) {
                              return MovieCard(snapshot.data.movies[index],
                                  snapshot.data.movies[index].poster_path);
                            }),
                      ),
                      Divider(),
                      Row(
                        children: [

                          Text(
                            '    MELHORES FILMES',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      TopRatedMovieList()
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}

class MovieCard extends StatelessWidget {
  final imagePath;
  final MovieList movie;
  MovieCard(this.movie, this.imagePath);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      child: Card(
          color: Colors.black,
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Image.network(
            'https://image.tmdb.org/t/p/w300${movie.poster_path}' ==
                    'https://image.tmdb.org/t/p/w300null'
                ? 'https://www.freeshop.com.br/pdv/imagens/imagemindisponivel.png'
                : 'https://image.tmdb.org/t/p/w300${movie.poster_path}',
            fit: BoxFit.fill,
          )),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MovieDetailsView(movie)));
      },
    );
  }
}

class TopRatedMovieList extends StatefulWidget {
  @override
  _TopRatedMovieListState createState() => _TopRatedMovieListState();
}

class _TopRatedMovieListState extends State<TopRatedMovieList> {
  final controller = MovieViewModel();
  var _listController = ScrollController();

  @override


  void initState() {
    super.initState();
controller.loadRatedMovie();

    _listController.addListener(() {
      final pixel = _listController.position.pixels;
      if (pixel == _listController.position.maxScrollExtent) {
        controller.updateRatedList();
      }
    });
  }

  Widget build(BuildContext context) {
    return StreamBuilder<TopRatedMovie>(
      stream: controller.streamTopRatedMovie.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.active) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.5,
            padding: EdgeInsets.only(top: 15),
            child: ListView.separated(
                controller: _listController,
                scrollDirection: Axis.horizontal,

                separatorBuilder: (context, index) => VerticalDivider(
                      width: 20,
                    ),
                itemCount: snapshot.data.ratedmovies.length,
                itemBuilder: (context, indexRated) {
                  return InkWell(
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    child: Card(
                        color: Colors.black,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w300${snapshot.data.ratedmovies[indexRated].poster_path}',
                          fit: BoxFit.fill,
                        )),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TopRatedMoviesDetailsView(indexRated)));
                    },
                  );
                }),
          );
        }
        return Container();
      },
    );
  }
}