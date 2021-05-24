import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

import '../../core/locator.dart';
import '../../core/models/genre_model.dart';
import '../../core/models/movie_model.dart';
import '../../core/routes/router_path.dart';
import '../../core/services/navigator_service.dart';
import '../../core/services/tmdb_data_service.dart';

class HomeScreenModel extends BaseViewModel {
  final TmdbDataService _tmdbDataService = locator<TmdbDataService>();
  final NavigationService _navigationService = locator<NavigationService>();

  List<MovieModel> _trendingMovieList = [];
  List<MovieModel> get trendingMovieList => _trendingMovieList;

  List<MovieModel> _popularMovieList = [];
  List<MovieModel> get popularMovieList => _popularMovieList;

  List<MovieModel> _topRatedMovieList = [];
  List<MovieModel> get topRatedMovieList => _topRatedMovieList;

  List<MovieModel> _upComingMovieList = [];
  List<MovieModel> get upComingMovieList => _upComingMovieList;

  List<MovieModel> _nowPlayingMovieList = [];
  List<MovieModel> get nowPlayingMovieList => _nowPlayingMovieList;

  List<Genres> _genresMovieList = [];
  List<Genres> get genresMovieList => _genresMovieList;

  int carIndex;

  void initializeHomeScreen() async {
    setBusy(true);

    carIndex = 0;

    _trendingMovieList = await _tmdbDataService.fetchTrendingMovies();
    _popularMovieList = await _tmdbDataService.fetchPopularMovies();
    _topRatedMovieList = await _tmdbDataService.fetchTopMovies();
    _genresMovieList = await _tmdbDataService.fetchGenreList();
    _nowPlayingMovieList = await _tmdbDataService.fetchNowPlayingMovies();

    setBusy(false);
    notifyListeners();
    getUpComingMovies();
  }

  void getUpComingMovies() async {
    _upComingMovieList = await _tmdbDataService.fetchUpcomingMovis();
    notifyListeners();
  }

  void onCarousalChange(int index) {
    carIndex = index;
    notifyListeners();
  }

  void handleGenreTap(Genres genres) {
    _navigationService.navigateTo(kGenreMovieScreen, arguments: genres);
  }

  void handleSearchTap() {
    _navigationService.navigateTo(kMovieSearchScreen);
  }

  void handleMovieTileTap(MovieModel movieModel) {
    _navigationService.navigateTo(kMovieDetailScreen, arguments: movieModel);
  }

  void handleBtnLftTap() {
    // _navigationService.pop();
    SystemNavigator.pop();
  }

  void handleBtnRgtTap() {
    // _navigationService.pop();
    initializeHomeScreen();
  }
}
