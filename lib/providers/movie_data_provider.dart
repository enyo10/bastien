import 'package:bastien/models/movie_data.dart';
import 'package:bastien/providers/movie_parameter_provider.dart';
import 'package:bastien/services/api.dart';
import 'package:bastien/services/web_service.dart';
import 'package:flutter/cupertino.dart';

class MovieDataProvider extends ChangeNotifier {
  final MovieParametersProvider movieParametersProvider;
  int _actualPageNumber = 1;
  int get actualPagNumber => _actualPageNumber;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _minReleaseData;
  int _maxReleaseData;

  MovieDataProvider(this.movieParametersProvider);



  Future<List<MovieData>> fetchMoviesDataWithRuntime() async {
    _isLoading = true;
    List<MovieData> movieDataList = [];

    var list = await Webservice().load(Api.fetchMoviesData(_actualPageNumber));

    for (MovieData element in list) {
      await Webservice()
          .load(Api.fetchMovieDataWithRuntime(element))
          .then((value) => movieDataList.add(value));
    }

    _isLoading = false;
    return movieDataList;
  }

  Future<List<MovieData>> searchMovie(String query) async {
    _isLoading = true;

    var list = await Webservice().load(Api.searchMovie(query));
    List<MovieData> movieDataList = [];

    if (list.isNotEmpty) {
      for (MovieData element in list) {
        await Webservice()
            .load(Api.fetchMovieDataWithRuntime(element))
            .then((value) => movieDataList.add(value));
      }
    }
    _isLoading = false;
    return movieDataList;
  }



  void up() {
    _actualPageNumber++;
    notifyListeners();
  }

  void down() {
    _actualPageNumber--;
    notifyListeners();
  }
}
