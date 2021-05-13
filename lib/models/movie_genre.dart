class MovieGenre {
  final String text;
  final int genre;

  MovieGenre(this.text, this.genre);

  MovieGenre.fromJSON(Map<String, dynamic> json)
      : genre = json["id"],
        text  = json["name"];

  bool operator ==(dynamic other) =>
      other != null && other is MovieGenre && this.text == other.text;

  @override
  int get hashCode => super.hashCode;
}

class MovieGenresList {
  List<MovieGenre> genres = <MovieGenre>[];

  MovieGenresList.fromJSON(Map<String, dynamic> json)
      : genres = (json["genres"] as List<dynamic>)
      .map((item) => MovieGenre.fromJSON(item)).toList();

  //
  // Return the genre by its id
  //
  MovieGenre findById(int genre) => genres.firstWhere((g) => g.genre == genre);
}

