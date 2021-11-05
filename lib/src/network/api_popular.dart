import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:practica2/src/models/movies%20models/act_model.dart';
import 'package:practica2/src/models/movies%20models/popular_movies_model.dart';

class ApiPopular {

  final Dio _dio = Dio();
  // ignore: non_constant_identifier_names
  var URL = Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=7aaa34632a1da07d176705660bccabeb&language=en-US&page=1');

  final String base = 'https://api.themoviedb.org/3';
  final String apiKey= 'api_key=7aaa34632a1da07d176705660bccabeb';

  Future<List<PopularMoviesModel>?> getAllPopular() async{
    final response = await http.get(URL);
    if (response.statusCode==200) {
      var popular = jsonDecode(response.body)['results'] as List;
      List<PopularMoviesModel> listPopular = popular.map((movie)=>PopularMoviesModel.fromMap(movie)).toList();
      return listPopular;
    }else{
      return null;
    }
  }

  Future<PopularMoviesModel> getMovieDetail(int movieId) async {
    try {
      final response = await _dio.get(
          'https://api.themoviedb.org/3/movie/$movieId?api_key=5a8ed5c7a19857d34088f938b9fc444d&page=1');
      PopularMoviesModel movieDetail = PopularMoviesModel.fromJson(response.data);
      movieDetail.castList = await getCastList(movieId);
      movieDetail.trailerId = await getYoutubeId(movieId);
      return movieDetail;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<Cast>> getCastList(int movieId) async {
    try {
      final response = await _dio.get(
          'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=5a8ed5c7a19857d34088f938b9fc444d&page=1');
      var list = response.data['cast'] as List;
      List<Cast> castList = list
          .map((c) => Cast(
              name: c['name'],
              profilePath: c['profile_path'],
              character: c['character']))
          .toList();
      return castList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<String> getYoutubeId(int id) async {
    try {
      final response = await _dio.get(
          'https://api.themoviedb.org/3/movie/$id/videos?api_key=5a8ed5c7a19857d34088f938b9fc444d&page=1');
      var youtubeId = response.data['results'][0]['key'];
      return youtubeId;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }


}