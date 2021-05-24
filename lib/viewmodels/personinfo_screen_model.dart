import 'package:stacked/stacked.dart';

import '../core/locator.dart';
import '../core/models/movie_model.dart';
import '../core/models/person_info_model.dart';
import '../core/routes/router_path.dart';
import '../core/services/navigator_service.dart';
import '../core/services/tmdb_data_service.dart';

class PersonInfoScreenModel extends BaseViewModel {
  final TmdbDataService _tmdbDataService = locator<TmdbDataService>();
  final NavigationService _navigationService = locator<NavigationService>();

  PersonInfo _personInfo;
  PersonInfo get personInfo => _personInfo;

  List<MovieModel> _personMoviesList;
  List<MovieModel> get personMoviesList => _personMoviesList;

  Future initializePersonInfoScreen(int id) async {
    setBusy(true);
    print("person id: $id");
    _personInfo = await _tmdbDataService.fetchPersonInfo(id);
    _personMoviesList = await _tmdbDataService.fetchPersonMovies(id);
    notifyListeners();
    setBusy(false);
  }

  void handlePersonMoviesTap(MovieModel _movieDetails) {
    _navigationService.navigateTo(kMovieDetailScreen, arguments: _movieDetails);
  }

  void handleBackPress() {
    _navigationService.pop();
  }
}
