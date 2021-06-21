import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
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

  @override
  void initState() {
    super.initState();
    controller.loadMovie();
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pt_br');
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
                      Header(),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.65,
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
                              if (index == snapshot.data.movies.length - 1) {
                                controller.updateList();
                              }
                              return MovieCard(snapshot.data.movies[index],
                                  snapshot.data.movies[index].poster_path);
                            }),
                      ),
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

class Header extends StatefulWidget {
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Column(
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
                  'Movie App',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.left,
                ),
                Divider(),
                Text(
                  'Hoje, ${DateFormat.MMMd('pt_BR').format(now)}',
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
              backgroundImage: NetworkImage(
                  'https://ih0.redbubble.net/image.618385909.1713/flat,1000x1000,075,f.u2.jpg'),
              backgroundColor: Colors.black,
              radius: 30,
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
      ],
    );
  }
}

// class TopRatedMovieList extends StatefulWidget {
//   @override
//   _TopRatedMovieListState createState() => _TopRatedMovieListState();
// }
//
// class _TopRatedMovieListState extends State<TopRatedMovieList> {
//   final controller = MovieViewModel();
//
//   @override
//   void initState() {
//     super.initState();
//     controller.loadRatedMovie();
//   }
//
//   Widget build(BuildContext context) {
//     return StreamBuilder<TopRatedMovie>(
//       stream: controller.streamTopRatedMovie.stream,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState != ConnectionState.active) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//         if (snapshot.hasData) {
//           return Container(
//             width: MediaQuery.of(context).size.width * 0.8,
//             height: MediaQuery.of(context).size.height * 0.5,
//             padding: EdgeInsets.only(top: 15),
//             child: ListView.separated(
//                 scrollDirection: Axis.horizontal,
//                 separatorBuilder: (context, index) => VerticalDivider(
//                       width: 20,
//                     ),
//                 itemCount: snapshot.data.ratedmovies.length,
//                 itemBuilder: (context, indexRated) {
//                   if (indexRated == snapshot.data.ratedmovies.length - 1) {
//                     controller.updateRatedList();
//                   }
//                   return InkWell(
//                     highlightColor: Colors.transparent,
//                     hoverColor: Colors.transparent,
//                     child: Card(
//                         color: Colors.black,
//                         clipBehavior: Clip.antiAlias,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(15)),
//                         child: Image.network(
//                           'https://image.tmdb.org/t/p/w300${snapshot.data.ratedmovies[indexRated].poster_path}',
//                           fit: BoxFit.fill,
//                         )),
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => TopRatedMoviesDetailsView(
//                                   snapshot.data.ratedmovies[indexRated])));
//                     },
//                   );
//                 }),
//           );
//         }
//         return Container();
//       },
//     );
//   }
// }
