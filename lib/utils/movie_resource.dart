import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class MovieResource<T> {
  final String url;
  T Function(Response response) parse;

  MovieResource({@required this.url, @required this.parse});
}
