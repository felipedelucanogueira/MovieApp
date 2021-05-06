import 'package:flutter/material.dart';
import 'package:movie_app/movie_controller.dart';
import 'package:movie_app/movie_details_view.dart';
import 'package:movie_app/top_rated_movies_details_view.dart';
import 'movie.dart';

class MovieView extends StatefulWidget {
  @override
  _MovieViewState createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  final controller = MovieController();

  @override
  Widget build(BuildContext context) {
    controller.loadMovie();
    controller.loadRatedMovie();

    return FutureBuilder<Movie>(
      future: controller.movie,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
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
                            backgroundImage: NetworkImage(
                                'https://scontent.fimp3-1.fna.fbcdn.net/v/t1.6435-9/80805869_2757212047706331_5025341886437523456_n.jpg?_nc_cat=100&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=52GjzwvtiNMAX9uqNFz&_nc_ht=scontent.fimp3-1.fna&oh=9beccf8045967b15a0725d0aeca26595&oe=60B3B236'),
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
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            separatorBuilder: (context, index) =>
                                VerticalDivider(
                                  width: 20,
                                ),
                            itemCount: snapshot.data.movies.length,
                            itemBuilder: (context, index) {
                              return MovieCard(index,
                                  snapshot.data.movies[index].poster_path);
                            }),
                      ),
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

class MovieCard extends StatefulWidget {
  var imagePath;
  var index;
  MovieCard(this.index, this.imagePath);

  @override
  _MovieCardState createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.454,
              child: Card(
                  color: Colors.black,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w300${widget.imagePath}',
                    fit: BoxFit.fill,
                  ))),
          Divider(),
        ],
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieDetailsView(widget.index)));
      },
    );
  }
}

class TopRatedMovieList extends StatefulWidget {
  @override
  _TopRatedMovieListState createState() => _TopRatedMovieListState();
}

class _TopRatedMovieListState extends State<TopRatedMovieList> {
  final controller = MovieController();
  @override
  Widget build(BuildContext context) {
    controller.loadRatedMovie();
    return FutureBuilder<TopRatedMovie>(
      future: controller.ratedMovie,
      builder: (context, snapshot) {
        controller.loadRatedMovie();
        if (snapshot.connectionState != ConnectionState.done) {
          controller.loadRatedMovie();
          return CircularProgressIndicator();
        }
        if (snapshot.hasData) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.5,
            padding: EdgeInsets.only(top: 15),
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                separatorBuilder: (context, index) => VerticalDivider(
                      width: 20,
                    ),
                itemCount: snapshot.data.ratedmovies.length,
                itemBuilder: (context, indexRated) {
                  return InkWell(
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.height * 0.454,
                            child: Card(
                                color: Colors.black,
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w300${snapshot.data.ratedmovies[indexRated].poster_path}',
                                  fit: BoxFit.fill,
                                ))),
                        Divider(),
                      ],
                    ),
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
