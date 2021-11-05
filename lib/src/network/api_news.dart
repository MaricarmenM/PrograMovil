import 'dart:convert';

import 'package:practica2/src/models/news%20models/details_model.dart';
import 'package:http/http.dart' as http;

class ApiNews {
 
  final URL = Uri.parse('https://newsapi.org/v2/everything?domains=wsj.com&apiKey=147b0bb72d1d40b0bc84f3a340087fd0');

  Future<List<DetailNewsModel>> getArticle() async {
    final res = await http.get(URL);
    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);
      List<dynamic> body = json['articles'];
      List<DetailNewsModel> articles = body.map((dynamic item) => DetailNewsModel.fromJson(item)).toList();
      return articles;
    } else {
      throw ("Can't get results");
    }
  }

}