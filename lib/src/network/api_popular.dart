import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:practica2/src/models/popular_movies_model.dart';

class ApiPopular {

  // ignore: non_constant_identifier_names
  var URL = Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=7aaa34632a1da07d176705660bccabeb&language=en-US&page=1');
 
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
}