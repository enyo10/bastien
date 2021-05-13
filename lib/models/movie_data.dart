class MovieData {
  int voteCount;
  int id;
  bool video;
  String voteAverage;
  String title;
  var popularity;
  String posterPath;
  String originalLanguage;
  String originalTitle;
  List<dynamic> genreIds;
  String backdropPath;
  bool adult;
  String overview;
  String releaseDate;
  int runtime;

  MovieData({
    this.id,
    this.voteCount,
    this.video,
    this.voteAverage,
    this.title,
    this.popularity,
    this.posterPath,
    this.originalLanguage,
    this.originalTitle,
    this.backdropPath,
    this.adult,
    this.overview,
    this.releaseDate,
    this.genreIds,
    this.runtime,
  });

  factory MovieData.fromJson(Map<String, dynamic> json) {
    return MovieData(
        voteCount:json['vote_count'] as int,
        id: json['id'] as int,
        video: json['video'],
        voteAverage: json['vote_average'].toString(),
        title: json['title'],
        popularity: json['popularity'] ,
        posterPath: json['poster_path'],
        originalLanguage: json['original_language'],
        originalTitle: json['original_title'],

        backdropPath: json['backdrop_path'],
        adult: json['adult'],
        overview: json['overview'],
        releaseDate: json['release_date'],
        genreIds: json['genre_ids']
    );
  }
}
