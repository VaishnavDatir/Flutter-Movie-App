import 'package:flutter/material.dart';

import '../../views/screens/genre_movie_screen.dart';
import '../../views/screens/home_screen.dart';
import '../../views/screens/movie_detail_screen.dart';
import '../../views/screens/movie_search_screen.dart';
import '../../views/screens/movie_video_screen.dart';
import '../../views/screens/person_info_screen.dart';
import 'router_path.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case kHomeScreen:
      return MaterialPageRoute(builder: (context) => HomeScreen());
      break;

    case kMovieDetailScreen:
      return MaterialPageRoute(
          builder: (context) => MovieDetailScreen(settings.arguments));
      break;

    case kGenreMovieScreen:
      return MaterialPageRoute(
          builder: (context) => GenreMoveScreen(settings.arguments));
      break;

    case kPersonInfoScreen:
      return MaterialPageRoute(
          builder: (context) => PersonInfoScreen(settings.arguments));
      break;

    case kMovieVideoScreen:
      return MaterialPageRoute(
          builder: (context) => MovieVideoScreen(settings.arguments));
      break;

    case kMovieSearchScreen:
      return MaterialPageRoute(builder: (context) => MovieSearchScreen());
      break;

    default:
      return MaterialPageRoute(builder: (context) => HomeScreen());
      break;
  }
}
