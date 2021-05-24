class MovieModel {
  List<int> genreIds;
  String originalLanguage;
  String originalTitle;
  String posterPath;
  int id;
  double voteAverage;
  String overview;
  String releaseDate;
  int voteCount;
  bool video;
  bool adult;
  String backdropPath;
  String title;
  double popularity;
  String mediaType;

  MovieModel(
      {this.genreIds,
      this.originalLanguage,
      this.originalTitle,
      this.posterPath,
      this.id,
      this.voteAverage,
      this.overview,
      this.releaseDate,
      this.voteCount,
      this.video,
      this.adult,
      this.backdropPath,
      this.title,
      this.popularity,
      this.mediaType});

  MovieModel.fromJson(Map<String, dynamic> json)
      : genreIds = json['genre_ids'].cast<int>(),
        originalLanguage = json['original_language'],
        originalTitle = json['original_title'],
        posterPath = json['poster_path'],
        id = json['id'],
        voteAverage = json['vote_average']?.toDouble() ?? 0.0,
        overview = json['overview'],
        releaseDate = json['release_date'],
        voteCount = json['vote_count'],
        video = json['video'],
        adult = json['adult'],
        backdropPath = json['backdrop_path'],
        title = json['title'],
        popularity = json['popularity']?.toDouble() ?? 0.0,
        mediaType = json['media_type'];

  Map<String, dynamic> toJson() {
    return {
      'genre_ids': this.genreIds,
      'original_language': this.originalLanguage,
      'original_title': this.originalTitle,
      'poster_path': this.posterPath,
      'id': this.id,
      'vote_average': this.voteAverage,
      'overview': this.overview,
      'release_date': this.releaseDate,
      'vote_count': this.voteCount,
      'video': this.video,
      'adult': this.adult,
      'backdrop_path': this.backdropPath,
      'title': this.title,
      'popularity': this.popularity,
      'media_type': this.mediaType,
    };
  }
}
