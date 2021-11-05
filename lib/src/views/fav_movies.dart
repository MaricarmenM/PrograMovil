import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/movies%20models/favMovie_model.dart';
import 'package:practica2/src/models/movies%20models/popular_movies_model.dart';
import 'package:practica2/src/network/api_popular.dart';
import 'package:practica2/src/views/card_popular.dart';


class FavMoviesScreen extends StatefulWidget {
  const FavMoviesScreen({ Key? key }) : super(key: key);

  @override
  _FavMoviesScreenState createState() => _FavMoviesScreenState();
}

class _FavMoviesScreenState extends State<FavMoviesScreen> {

   ApiPopular? apiPopular;
  late DatabaseHelper _databaseHelper;

  @override
  void initState() {
    super.initState();
    apiPopular = ApiPopular();
    _databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('Favorite Movies'),
      ),
      body: FutureBuilder(
        future: _databaseHelper.getAllFavs(),
        builder: (BuildContext context,AsyncSnapshot<List<
          FavMovieModel>?> snapshot){
            if (snapshot.hasError) {
              return Center(
                child: Text('Hay error en la peticion') ,);
            }else{
              if (snapshot.connectionState == ConnectionState.done) {
                return _listFavoriteMovies(snapshot.data);
              }else{
                return CircularProgressIndicator();
              }
            }
        }
      ),
  
    );
  }

    Widget _listFavoriteMovies(List<FavMovieModel>? movies){
    return ListView.separated(
      itemBuilder: (context,index){
        FavMovieModel favorito = movies![index]; 
        PopularMoviesModel popular = new PopularMoviesModel(
          id: movies[index].id,
          title: movies[index].title,
          backdropPath: movies[index].backdropPath
        );
        return CardPopularView(popular: popular);
      },
      separatorBuilder: (_, __) => Divider(height: 10,),
      itemCount: movies!.length,
    );
  }



}