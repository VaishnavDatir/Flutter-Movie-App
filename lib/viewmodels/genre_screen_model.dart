import 'package:stacked/stacked.dart';

import '../../core/locator.dart';
import '../../core/models/movie_model.dart';
import '../../core/routes/router_path.dart';
import '../../core/services/navigator_service.dart';
import '../../core/services/tmdb_data_service.dart';

class GenreScreenModel extends BaseViewModel {
  final TmdbDataService _tmdbDataService = locator<TmdbDataService>();
  final NavigationService _navigationService = locator<NavigationService>();

  List<MovieModel> _genreMovieList = [];
  List<MovieModel> get genreMovieList => _genreMovieList;
  void initializeGenreScreen(int id) async {
    setBusy(true);
    _genreMovieList = await _tmdbDataService.fetchMovieByGenre(id);
    notifyListeners();
    setBusy(false);
  }

  void handleMovieTap(MovieModel _movie) async {
    _navigationService.navigateTo(kMovieDetailScreen, arguments: _movie);
  }

  void handleBackPress() {
    _navigationService.pop();
  }
}
