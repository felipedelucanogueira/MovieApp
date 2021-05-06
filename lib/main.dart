import 'package:flutter/material.dart';
import 'package:movie_app/movie_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
      debugShowCheckedModeBanner: false,

      home:MovieView()
    );
  }
}
