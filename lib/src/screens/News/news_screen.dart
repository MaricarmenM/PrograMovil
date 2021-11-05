


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practica2/src/models/news%20models/details_model.dart';
import 'package:practica2/src/network/api_news.dart';
import 'package:practica2/src/screens/News/card_new.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({ Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  ApiNews? apiNews;

  @override
  void initState(){
    super.initState();
    apiNews = ApiNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor:  Colors.blueGrey,
         title: Text('Today News'),
      ),
      body: FutureBuilder(
        future: apiNews!.getArticle(),
        builder: (BuildContext context,AsyncSnapshot<List<DetailNewsModel>?> snapshot){
            if (snapshot.hasError) {
              return Center(
                child: Text('Hay error en la peticion') ,);
            }else{
              if (snapshot.connectionState == ConnectionState.done) {
                return _listAllNews(snapshot.data);
              }else{
                return CircularProgressIndicator();
              }
            }
        }
      ),
    );
  }
  
  Widget _listAllNews(List<DetailNewsModel>? noticias){
    return ListView.separated(
      itemBuilder: (context,index){
        DetailNewsModel news = noticias![index]; 
        return CardNewsView(news: news);
      },
      separatorBuilder: (_, __) => Divider(height: 0,),
      itemCount: noticias!.length,
    );
  }
}