import 'package:stacked/stacked.dart';

import '../core/locator.dart';
import '../core/models/movie_video_model.dart';
import '../core/services/navigator_service.dart';

class MovieVideosScreenViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  String _movieName;
  String get movieName => _movieName;

  List<MovieVideo> _movieVideosList;
  List<MovieVideo> get movieVideosList => _movieVideosList;

  void initializeMovieVideoScreen(Map<String, dynamic> movieData) {
    setBusy(true);
    _movieName = movieData["movieName"];
    _movieVideosList = movieData["movieVideosList"];
    setBusy(false);
    notifyListeners();
  }

  void handleBackPress() {
    _navigationService.pop();
  }
}
