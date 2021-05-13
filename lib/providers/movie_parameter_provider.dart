import 'package:bastien/models/movie_genre.dart';
import 'package:bastien/models/sort_options.dart';
import 'package:bastien/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:bastien/utils/constants.dart';

class MovieParametersProvider extends ChangeNotifier {
  var _queryParameters = {'api_key': API_KEY, 'language': 'fr'};

  RangeValues _rangeValues = RangeValues(2000, 2007);
 // MovieGenre _movieGenre = MovieGenre("Action", 28);


  get rangeValues => _rangeValues;

  void setRangeValue(RangeValues values) {
    _rangeValues = values;
    notifyListeners();
  }

  MovieGenre _movieGenre;
  get movieGenre => _movieGenre;

  void setMovieGenre(MovieGenre movieGenre) {
    _movieGenre = movieGenre;
    notifyListeners();
  }

//  get selectedOption =>_sortOption;


}
