import 'package:stacked/stacked.dart';

import '../../core/locator.dart';
import '../../core/models/genre_model.dart';
import '../../core/models/movie_cast_model.dart';
import '../../core/models/movie_info_model.dart';
import '../../core/models/movie_model.dart';
import '../../core/routes/router_path.dart';
import '../../core/services/navigator_service.dart';
import '../../core/services/tmdb_data_service.dart';
import '../core/models/movie_video_model.dart';

class MovieDetailModel extends BaseViewModel {
  final TmdbDataService _tmdbDataService = locator<TmdbDataService>();
  final NavigationService _navigationService = locator<NavigationService>();

  MovieInfoModel _curMovieDetails;
  MovieInfoModel get curMovieDetails => _curMovieDetails;

  List<MovieCast> _curMovieCast;
  List<MovieCast> get curMovieCast => _curMovieCast;

  List<MovieModel> _similarMoviesList;
  List<MovieModel> get similarMoviesList => _similarMoviesList;

  List<MovieVideo> _movieVideos;
  List<MovieVideo> get movieVideos => _movieVideos;

  bool _isVideoAvailable = false;
  bool get isVidoeAvailable => _isVideoAvailable;

  void initializeMovieDetailScreen(MovieModel _movieDetails) async {
    print(_movieDetails.id);
    setBusy(true);
    _curMovieDetails =
        await _tmdbDataService.fetchMovieDetails(_movieDetails.id);
    _curMovieCast = await _tmdbDataService.fetchMovieCast(_movieDetails.id);
    _similarMoviesList =
        await _tmdbDataService.fetchSimilarMovies(_movieDetails.id);

    notifyListeners();
    setBusy(false);
    getMoviesVideos(_movieDetails.id);
  }

  void getMoviesVideos(int id) async {
    _movieVideos = await _tmdbDataService.fetchMovieVideos(id);
    if (_movieVideos.isNotEmpty) {
      _isVideoAvailable = true;
    }
    notifyListeners();
  }

  void handleGenreTap(Genres genres) {
    _navigationService.navigateTo(kGenreMovieScreen, arguments: genres);
  }

  void handleSimilarMoviesTap(MovieModel _movieDetails) {
    _navigationService.navigateTo(kMovieDetailScreen, arguments: _movieDetails);
  }

  void handlePersonTap(int id) {
    _navigationService.navigateTo(kPersonInfoScreen, arguments: id);
  }

  void handlePlayBtnTap() {
    _navigationService.navigateTo(kMovieVideoScreen, arguments: {
      "movieName": _curMovieDetails.title,
      "movieVideosList": _movieVideos,
    });
  }

  void handleBackPress() {
    _navigationService.pop();
  }
}
