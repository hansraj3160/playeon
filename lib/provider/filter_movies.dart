import 'package:flutter/material.dart';
import 'package:playeon/models/movies_model.dart';

class MoviesGenraProvider extends ChangeNotifier {
  List<MoviesModel> actionGenra = [];
  List<MoviesModel> sci_fiGenra = [];
  List<MoviesModel> animeGenra = [];
  List<MoviesModel> funnyGenra = [];
  List<MoviesModel> horrorGenra = [];
  List<MoviesModel> romanticGenra = [];
  List<MoviesModel> adventureGenra = [];
  List<MoviesModel> thrillerGenra = [];
  List<MoviesModel> cartoonGenra = [];
  List<MoviesModel> moviesGenra = [];

  setFilterGenra(List<MoviesModel> lst) {
    for (var movies in lst) {
      if (movies.genre![0] == 'action') {
        actionGenra.add(movies);
      } else if (movies.genre![0] == 'action') {
        actionGenra.add(movies);
      }
    }
  }

  setMovies(List<MoviesModel> movie) {
    moviesGenra = movie;
    notifyListeners();
  }
}
