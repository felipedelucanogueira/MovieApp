import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/Scenes/movie.dart';
import 'package:movie_app/Scenes/moviesHome/movieViewModel.dart';

class MovieDetailsView extends StatefulWidget {
  final MovieList movie;
  MovieDetailsView(this.movie);

  @override
  _MovieDetailsViewState createState() => _MovieDetailsViewState();
}

class _MovieDetailsViewState extends State<MovieDetailsView> {
  final controller = MovieViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowGlow();
            return;
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RotatedBox(
                      quarterTurns: 0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FloatingActionButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            backgroundColor: Colors.white.withOpacity(0.2),
                            child: Icon(
                              Icons.arrow_back_ios,
                            ),
                          ),
                          Divider(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          FutureBuilder<String>(
                            future:controller.movieId(widget.movie.id),
                             builder:(context,snapshot){
                              var isFavorite = snapshot.data != null;
                              return IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if(isFavorite){
                                        controller.deleteMovie(widget.movie.id);
                                      }else{
                                        controller.saveUser(widget.movie.id, widget.movie);
                                      }
                                    });
                                  },
                                  icon: FaIcon(
                                    isFavorite ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
                                    color: isFavorite ? Colors.red : Colors.white,
                                  ));

                             },

                          ),
                          Text(
                            'Favoritar',
                            style: TextStyle(color: Colors.white),
                          ),
                          Divider(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.white,
                          ),
                          Text(
                            widget.movie.release_date,
                            style: TextStyle(color: Colors.white),
                          ),
                          Divider(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Icon(
                            Icons.star_border,
                            color: Colors.white,
                          ),
                          Divider(
                            height: 5,
                          ),
                          Text(
                            widget.movie.vote_average.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Card(
                            color: Colors.black,
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Stack(
                              fit: StackFit.loose,
                              children: [
                                Image.network(
                                    'https://image.tmdb.org/t/p/w300${widget.movie.poster_path}'),
                              ],
                            )))
                  ],
                ),
                Divider(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Text(
                  widget.movie.title,
                  style: TextStyle(color: Colors.white, fontSize: 17),
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
                      style: TextStyle(color: Colors.black, fontSize: 17),
                      textAlign: TextAlign.center,
                    )),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      controller.saveFavorite();
                    });
                  },
                  child: Text('Salvar Todos'),
                ),
                FutureBuilder<String>(
                    future: controller.movieId(widget.movie.id),
                    builder: (
                      context,
                      snapshot,
                    ) {
                      return Text(snapshot.data ?? 'nenhum filme adicionado',
                          style: TextStyle(color: Colors.white));
                    }),
                Divider(
                  height: 30,
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 30, left: 30),
                    child: Text(
                      widget.movie.overview.isNotEmpty
                          ? widget.movie.overview
                          : 'Sinopse não Disponivel',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                      textAlign: TextAlign.justify,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
