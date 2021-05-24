import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import '../models/movie_video_model.dart';
import '../models/person_info_model.dart';

import '../constants.dart';
import '../models/genre_model.dart';
import '../models/movie_cast_model.dart';
import '../models/movie_info_model.dart';
import '../models/movie_model.dart';

class TmdbDataService {
  Future fetchTrendingMovies() async {
    print("Called fetchTrendingMovies");
    var url = Uri.parse(kbaseUrl + "trending/movie/day" + kauthKey);
    var response = await http.get(url);
    List<MovieModel> _trendingMoviesList = [];
    if (response.statusCode.toString() == "200") {
      var jsonResponse = convert.jsonDecode(response.body);
      final results = jsonResponse["results"] as List<dynamic>;
      results.forEach((element) {
        _trendingMoviesList.add(MovieModel.fromJson(element));
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return _trendingMoviesList;
  }

  Future fetchPopularMovies() async {
    print("Called fetchPopularMovies");
    var url = Uri.parse(kbaseUrl +
        "movie/popular" +
        kauthKey +
        "&language=en-US&page=1&region=IN");
    var response = await http.get(url);
    if (response.statusCode.toString() == "200") {
      var jsonResponse = convert.jsonDecode(response.body);
      final results = jsonResponse["results"] as List<dynamic>;
      List<MovieModel> _popularMoviesList = [];
      results.forEach((element) {
        _popularMoviesList.add(MovieModel.fromJson(element));
      });
      return _popularMoviesList;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  Future fetchTopMovies() async {
    print("Called fetchTopMovies");
    List<MovieModel> _popularMoviesList = [];
    var url = Uri.parse(kbaseUrl +
        "movie/top_rated" +
        kauthKey +
        "&language=en-US&page=1&region=IN");
    var response = await http.get(url);
    if (response.statusCode.toString() == "200") {
      var jsonResponse = convert.jsonDecode(response.body);
      final results = jsonResponse["results"] as List<dynamic>;
      results.forEach((element) {
        _popularMoviesList.add(MovieModel.fromJson(element));
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return _popularMoviesList;
  }

  Future fetchNowPlayingMovies() async {
    print("Called fetchNowPlayingMovies");
    List<MovieModel> _nowPlayingMovies = [];
    var url = Uri.parse(kbaseUrl +
        "movie/now_playing" +
        kauthKey +
        "&language=en-US&page=1&region=IN");
    var response = await http.get(url);
    if (response.statusCode.toString() == "200") {
      var jsonResponse = convert.jsonDecode(response.body);
      final results = jsonResponse["results"] as List<dynamic>;
      results.forEach((element) {
        _nowPlayingMovies.add(MovieModel.fromJson(element));
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return _nowPlayingMovies;
  }

  Future fetchUpcomingMovis() async {
    print("Called fetchUpcomingMovis");
    List<MovieModel> _upComingMovies = [];
    var url = Uri.parse(kbaseUrl +
        "movie/upcoming" +
        kauthKey +
        "&language=en-US&page=1&region=IN");
    var response = await http.get(url);
    if (response.statusCode.toString() == "200") {
      var jsonResponse = convert.jsonDecode(response.body);
      final results = jsonResponse["results"] as List<dynamic>;
      results.forEach((element) {
        _upComingMovies.add(MovieModel.fromJson(element));
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return _upComingMovies;
  }

  Future fetchMovieDetails(int id) async {
    print("Called fetchMovieDetails");
    String movieId = id.toString();
    var url =
        Uri.parse(kbaseUrl + "movie/$movieId" + kauthKey + "&language=en-US");
    var response = await http.get(url);
    if (response.statusCode.toString() == "200") {
      var jsonResponse = convert.jsonDecode(response.body);
      MovieInfoModel _movieInfo = MovieInfoModel.fromJson(jsonResponse);
      return _movieInfo;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  Future fetchMovieCast(int id) async {
    print("Called fetchMovieCast");
    String movieId = id.toString();
    var url = Uri.parse(
        kbaseUrl + "movie/$movieId/credits" + kauthKey + "&language=en-US");
    List<MovieCast> _movieCastList = [];

    var response = await http.get(url);
    if (response.statusCode.toString() == "200") {
      var jsonResponse = convert.jsonDecode(response.body);
      final results = jsonResponse["cast"] as List<dynamic>;
      results.forEach((element) {
        _movieCastList.add(MovieCast.fromJson(element));
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return _movieCastList;
  }

  Future fetchMovieByGenre(int id) async {
    print("Called fetchMovieByGenre");
    String genreId = id.toString();
    List<MovieModel> _genreMoviesList = [];
    try {
      var url = Uri.parse(kbaseUrl +
          "discover/movie" +
          kauthKey +
          "&with_genres=$genreId&watch_region=in");

      var response = await http.get(url);
      if (response.statusCode.toString() == "200") {
        var jsonResponse = convert.jsonDecode(response.body);
        final results = jsonResponse["results"] as List<dynamic>;
        results.forEach((element) {
          _genreMoviesList.add(MovieModel.fromJson(element));
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
      var url2 = Uri.parse(kbaseUrl +
          "discover/movie" +
          kauthKey +
          "&with_genres=$genreId&page=2&watch_region=in");

      var response2 = await http.get(url2);
      if (response2.statusCode.toString() == "200") {
        var jsonResponse = convert.jsonDecode(response2.body);
        final results = jsonResponse["results"] as List<dynamic>;
        results.forEach((element) {
          _genreMoviesList.add(MovieModel.fromJson(element));
        });
      } else {
        print('Request failed with status: ${response2.statusCode}.');
      }
    } catch (e) {
      print(e);
    }
    return _genreMoviesList;
  }

  Future fetchGenreList() async {
    print("Called fetchGenreList");
    List<Genres> _genreList = [];
    var url = Uri.parse(kbaseUrl +
        "genre/movie/list" +
        kauthKey +
        "&language=en-&language=en-US");
    var response = await http.get(url);
    if (response.statusCode.toString() == "200") {
      var jsonResponse = convert.jsonDecode(response.body);
      final results = jsonResponse["genres"] as List<dynamic>;
      results.forEach((element) {
        _genreList.add(Genres.fromJson(element));
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return _genreList;
  }

  Future fetchSimilarMovies(int id) async {
    print("Called fetchSimilarMovies");
    String movieId = id.toString();
    List<MovieModel> _similarMoviesList = [];

    var url = Uri.parse(kbaseUrl +
        "movie/$movieId/similar" +
        kauthKey +
        "&language=en-&language=en-US&page=1");
    var response = await http.get(url);
    if (response.statusCode.toString() == "200") {
      var jsonResponse = convert.jsonDecode(response.body);
      final results = jsonResponse["results"] as List<dynamic>;
      results.forEach((element) {
        if (element["poster_path"] != null) {
          _similarMoviesList.add(MovieModel.fromJson(element));
        }
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return _similarMoviesList;
  }

  Future fetchPersonInfo(int id) async {
    print("Called fetchPersonInfo");
    String personId = id.toString();

    var url = Uri.parse(kbaseUrl + "person/$personId" + kauthKey);
    var response = await http.get(url);
    if (response.statusCode.toString() == "200") {
      var jsonResponse = convert.jsonDecode(response.body);
      PersonInfo _personInfo = PersonInfo.fromJson(jsonResponse);
      return _personInfo;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  Future fetchPersonMovies(int id) async {
    print("Called fetchPersonMovies");
    String personId = id.toString();
    var url = Uri.parse(kbaseUrl + "person/$personId/movie_credits" + kauthKey);
    List<MovieModel> _personMoviesList = [];

    var response = await http.get(url);

    if (response.statusCode.toString() == "200") {
      var jsonResponse = convert.jsonDecode(response.body);
      final results = jsonResponse["cast"] as List<dynamic>;
      results.forEach((element) {
        if (element['poster_path'] != null) {
          _personMoviesList.add(MovieModel.fromJson(element));
        }
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return _personMoviesList;
  }

  Future fetchMovieVideos(int id) async {
    print("Called fetchMovieVideos");
    String movieId = id.toString();

    List<MovieVideo> _moviesVideoList = [];

    var url = Uri.parse(kbaseUrl + "movie/$movieId/videos" + kauthKey);
    var response = await http.get(url);
    if (response.statusCode.toString() == "200") {
      var jsonResponse = convert.jsonDecode(response.body);
      final results = jsonResponse["results"] as List<dynamic>;
      results.forEach((element) {
        if (element["site"].toString().toLowerCase() == "youtube") {
          _moviesVideoList.add(MovieVideo.fromJson(element));
        }
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return _moviesVideoList;
  }

  Future fetchSearchMovie(String query) async {
    print("Called fetchSearchMovie");

    List<MovieModel> _serchMovieList = [];
    var url = Uri.parse(kbaseUrl +
        "search/movie" +
        kauthKey +
        "&language=en-US&query=$query&page=1&include_adult=true");

    var response = await http.get(url);

    if (response.statusCode.toString() == "200") {
      var jsonResponse = convert.jsonDecode(response.body);
      final results = jsonResponse["results"] as List<dynamic>;
      results.forEach((element) {
        if (element["poster_path"] != null) {
          _serchMovieList.add(MovieModel.fromJson(element));
        }
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return _serchMovieList;
  }
}
