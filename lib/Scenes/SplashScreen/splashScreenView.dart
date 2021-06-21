/// Demonstrates playing a one-shot animation on demand

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_app/Scenes/moviesHome/movieViewModel.dart';
import 'package:movie_app/Scenes/moviesHome/movie_view.dart';
import 'package:rive/rive.dart';

class SplashScreenView extends StatefulWidget {


  @override
  _SplashScreenViewState createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {

  RiveAnimationController _controller;
  bool _isPlaying = false;


  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3),(){
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => MovieView()));
    });
    _controller = OneShotAnimation(
      'bounce',
      autoplay: false,
      onStop: () => setState(() => _isPlaying = false),
      onStart: () => setState(() => _isPlaying = true),

    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: RiveAnimation.asset(
          'assets/zombie.riv',
          animations: const ['Walk'],
          controllers: [_controller],
        ),
      ),
    );
  }
}
