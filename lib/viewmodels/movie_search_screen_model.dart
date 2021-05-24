import 'package:stacked/stacked.dart';

import '../core/locator.dart';
import '../core/models/movie_model.dart';
import '../core/routes/router_path.dart';
import '../core/services/navigator_service.dart';
import '../core/services/tmdb_data_service.dart';

class MovieSearchScreenModel extends BaseViewModel {
  final TmdbDataService _tmdbDataService = locator<TmdbDataService>();
  final NavigationService _navigationService = locator<NavigationService>();

  List<MovieModel> _searchMovieList = [];
  List<MovieModel> get searchMovieList => _searchMovieList;

  void searchMovies(String _query) async {
    setBusy(true);
    _searchMovieList = await _tmdbDataService.fetchSearchMovie(_query);
    setBusy(false);
    notifyListeners();
  }

  void handleBackPress() {
    _navigationService.pop();
  }

  void handleMovieTileTap(MovieModel movieModel) {
    _navigationService.navigateTo(kMovieDetailScreen, arguments: movieModel);
  }

  void emptyList() {
    _searchMovieList = [];
    notifyListeners();
  }
}
