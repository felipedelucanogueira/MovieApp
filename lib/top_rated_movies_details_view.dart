import 'package:flutter/material.dart';
import 'package:movie_app/movie_controller.dart';

import 'movie.dart';

class TopRatedMoviesDetailsView extends StatefulWidget {
  int indexRated;
  TopRatedMoviesDetailsView(this.indexRated);

  @override
  _TopRatedMoviesDetailsViewState createState() =>
      _TopRatedMoviesDetailsViewState();
}

class _TopRatedMoviesDetailsViewState extends State<TopRatedMoviesDetailsView> {
  final controller = MovieController();
  @override
  Widget build(BuildContext context) {
    controller.loadRatedMovie();

    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overScroll) {
              overScroll.disallowGlow();
              return;
            },
            child: FutureBuilder<TopRatedMovie>(
                future: controller.ratedMovie,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Material(
                      color: Colors.black,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'OPS....Falha ao carregar',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            Container(
                                decoration: BoxDecoration(),
                                child: CircleAvatar(
                                    radius: 100,
                                    backgroundImage: NetworkImage(
                                        'https://i.pinimg.com/originals/c5/f0/a4/c5f0a40e2e509e67730eb5d6edcb5d38.gif'))),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.white),
                              onPressed: () {
                                setState(() {
                                  controller.loadRatedMovie();
                                });
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
                  if (snapshot.connectionState != ConnectionState.done) {
                    controller.loadRatedMovie();
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
                    return Column(
                      children: [
                        Text('Erro ao Carregar os Filmes'),
                        Divider(),
                        ElevatedButton(
                            onPressed: () {
                              controller.loadRatedMovie();
                            },
                            child: Text('Tentar Novamente'))
                      ],
                    );
                  }
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              RotatedBox(
                                quarterTurns: 8,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FloatingActionButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      backgroundColor:
                                          Colors.white.withOpacity(0.2),
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                      ),
                                    ),
                                    Divider(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                    ),
                                    Icon(
                                      Icons.timer_rounded,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      '2h 6min',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Divider(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.08,
                                    ),
                                    Icon(
                                      Icons.calendar_today_outlined,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      snapshot
                                          .data
                                          .ratedmovies[widget.indexRated]
                                          .release_date,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Divider(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.08,
                                    ),
                                    Icon(
                                      Icons.star_border,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      snapshot
                                          .data
                                          .ratedmovies[widget.indexRated]
                                          .vote_average
                                          .toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Divider(),
                                  ],
                                ),
                              ),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: Card(
                                      color: Colors.black,
                                      clipBehavior: Clip.antiAlias,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Image.network(
                                          'https://image.tmdb.org/t/p/w300${snapshot.data.ratedmovies[widget.indexRated].poster_path}')))
                            ],
                          ),
                          Divider(
                            height: 30,
                          ),
                          Text(
                            snapshot.data.ratedmovies[widget.indexRated].title,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          Divider(
                            height: 30,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              child: Text(
                                'SINOPSE',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                                textAlign: TextAlign.center,
                              )),
                          Divider(
                            height: 30,
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.only(right: 30, left: 30),
                              child: Text(
                                snapshot.data.ratedmovies[widget.indexRated]
                                    .overview,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                                textAlign: TextAlign.justify,
                              )),
                        ],
                      ),
                    );
                  }
                  return Container();
                }),
          ),
        ));
  }
}
