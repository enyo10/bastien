import 'dart:convert';

import 'package:bastien/models/movie_data.dart';
import 'package:bastien/models/movie_trailer.dart';
import 'package:bastien/utils/movie_resource.dart';

class Api {
  static const String Base_Url = "https://api.themoviedb.org/3/movie/";
  static const String Api_Key = "0faa98beb07d08a7fd094657f586e2b6";

  Api();

  static MovieResource<List<MovieData>> fetchMoviesData(int page) {
    return MovieResource(
      /* url: "http://api.themoviedb.org/3/movie/popular?api_key="
          "0faa98beb07d08a7fd094657f586e2b6&language=fr&page=$page",*/
      url: Uri.https('api.themoviedb.org', '/3/movie/upcoming', {
        'api_key': '0faa98beb07d08a7fd094657f586e2b6',
        'page': '$page',
        'language':'fr',
      }).toString(),
      parse: (response) {
        final result = json.decode(response.body);
        Iterable list = result['results'];
        return list.map((data) => MovieData.fromJson(data)).toList();
      },
    );
  }

  static void fetchDiscoverMovieData() {
    //Uri uri = Uri.http(authority, unencodedPath)
    var query = Map<String, dynamic>();

    // query.putIfAbsent('page', () => 1);
    final _params = {"q": "dart"};
    var uri = Uri.http('api.themoviedb.org', '/3/movie/upcoming', _params);
    print(" query data:  ${uri.data}");

    /* Uri.http(String authority, String unencodedPath,
      [Map<String, String> queryParameters]) = _Uri.http;*/
  }

  //Uri uri = Uri.http(authority, unencodedPath)

  /* Uri.http(String authority, String unencodedPath,
      [Map<String, String> queryParameters]) = _Uri.http;*/

  static MovieResource<List<MovieData>> searchMovie(String query,
      {String genre}) {
    return MovieResource(
      url: "https://api.themoviedb.org/3/search/movie?api_key"
          "=0faa98beb07d08a7fd094657f586e2b6&query=$query",
      parse: (response) {
        final result = json.decode(response.body);
        Iterable list = result['results'];
        return list.map((data) => MovieData.fromJson(data)).toList();
      },
    );
  }

  static MovieResource<MovieData> fetchMovieDataWithRuntime(
      MovieData movieData) {
    return MovieResource(
        url: "https://api.themoviedb.org/3/movie/${movieData.id}?"
            "api_key=0faa98beb07d08a7fd094657f586e2b6&append_to_response=videos",
        parse: (response) {
          var map = json.decode(response.body);
          int runtime = map['runtime'] as int;
          movieData.runtime = runtime;

          return movieData;
        });
  }

  static MovieResource<MovieTrailer> fetchMovieTrailer(int movieId) {
    return MovieResource(
        url:
            "http://api.themoviedb.org/3/movie/$movieId/videos?api_key=$Api_Key&language=fr",
        parse: (response) {
          var map = json.decode(response.body);
          return MovieTrailer.fromJson(map);
        });
  }
}
