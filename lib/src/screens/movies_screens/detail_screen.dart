import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/movies%20models/act_model.dart';
import 'package:practica2/src/models/movies%20models/favMovie_model.dart';
import 'package:practica2/src/models/movies%20models/popular_movies_model.dart';
import 'package:practica2/src/network/api_popular.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({ Key? key, this.popular}) : super(key: key);

   final PopularMoviesModel? popular;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool moviesFa = true;

  @override
  Widget build(BuildContext context) {
  
  DatabaseHelper _databaseHelper = DatabaseHelper();

  ApiPopular? apiPopular = ApiPopular();

  final movie = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;

  return Scaffold(
    appBar: AppBar(
       backgroundColor: Colors.black87,
        title: Text(''),
        actions: [
          IconButton(
             onPressed: (){
               if (moviesFa) {
                 FavMovieModel favMovie = FavMovieModel(
                  id: movie['id'],
                  title: movie['title'],
                  backdropPath: movie['backdrop'],
                );
                _databaseHelper.insertFav(favMovie.toMap()).then(
                  (value) {
                    if (value>0) {
                      Navigator.pop(context);
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Pelicula marcada como favorita!!')));
                          setState(() {});
                      }
                  }
                );
               } else {
                _databaseHelper.noFav(movie['id']).then(
                  (noRows){
                    if (noRows>0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Pelicula no favorita')));
                      setState(() {});
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('ERROR')));
                    }
                  }
                );
               }

             }, 
             icon: Icon(Icons.favorite_border_outlined)
             )
        ],
    ),
     body: FutureBuilder(
        future: apiPopular.getMovieDetail(movie['id']),
        builder: (BuildContext context,
            AsyncSnapshot<PopularMoviesModel?> snapshot) {
          if (snapshot.hasError) {
            return Container(child: 
            Column(
              children: [
                Center(child: Text('Ocurrio un error en la petición')),
              ],
            ));
          } else {
            if (snapshot.connectionState == ConnectionState.done) {
              return _movieDetails(snapshot.data, movie['id'], context);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        },
      ),

      );
  }

  Widget _movieDetails (PopularMoviesModel? movie, int id, BuildContext context){
    
     DatabaseHelper _databaseHelper = DatabaseHelper();
   
    YoutubePlayerController _controllerVideo = YoutubePlayerController(
      initialVideoId: '${movie!.trailerId}',
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false
      )
    );
   
  return FutureBuilder(
        future: _databaseHelper.getFav(id),
        builder: (BuildContext context,AsyncSnapshot<FavMovieModel?> snapshot) {
           if (snapshot.hasError) {
          return Center(child: Text('Ocurrio un error en la petición'));
        } else {
          if (snapshot.connectionState == ConnectionState.done) {
            FavMovieModel? movFavVery = snapshot.data;
                 if(movFavVery != null){
                   moviesFa = false;
                 }
   
              return SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                            Container(
                                child: Opacity(
                                  opacity: 0.8,
                                    child: Container(
                                      child: FadeInImage(
                                        placeholder: AssetImage('assets/activity_indicator.gif'),
                                        image: NetworkImage('https://image.tmdb.org/t/p/w500/${movie.backdropPath}'),
                                        fadeInDuration: Duration(milliseconds: 200),
                                      ),
                                    ),
                                ),
                            ),
                            Container( 
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Row(
                                children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: FadeInImage(
                                    placeholder: AssetImage('assets/activity_indicator.gif'),
                                    image: NetworkImage('https://image.tmdb.org/t/p/w500/${movie.posterPath}'),
                                    height: 250,
                                  ),
                                ),
                                SizedBox(width: 20,),
                                  Flexible(
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(movie.title!,textAlign: TextAlign.justify, style: Theme.of(context).textTheme.subtitle2, ),
                                          SizedBox(height: 10.0,),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                              child: Column(
                                children: [
                                  Text('OVERVIEW',textAlign: TextAlign.start, style: Theme.of(context).textTheme.subtitle2,),
                                  Text(movie.overview!,textAlign: TextAlign.justify,style: Theme.of(context).textTheme.subtitle1,)
                                ],
                              )
                            ),
                              Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Column(
                                children: [
                                  Text('TRAILER',textAlign: TextAlign.start, style: Theme.of(context).textTheme.subtitle2,),
                                  YoutubePlayer(
                                    controller: _controllerVideo,
                                    showVideoProgressIndicator: true,
                                    progressIndicatorColor: Colors.blueAccent,
                                  ),
                                ],
                              ),
                          ),
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Column(
                                children: [
                                  Text('CAST',textAlign: TextAlign.start, style: Theme.of(context).textTheme.subtitle2,),
                                  Container(
                                      height: 110,
                                      child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        separatorBuilder: (context, index) => VerticalDivider(
                                          color: Colors.transparent,
                                          width: 5,
                                        ),
                                        itemCount: movie.castList!.length,
                                        itemBuilder: (context, index) {
                                          Cast cast = movie.castList![index];
                                          return Container(
                                            child: Column(
                                              children: <Widget>[
                                                Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(100),
                                                  ),
                                                  elevation: 3,
                                                  child: ClipRRect(
                                                    child: CachedNetworkImage(
                                                      imageUrl: cast.profilePath != null
                                                          ? 'https://image.tmdb.org/t/p/w200${cast.profilePath}'
                                                          : 'https://as2.ftcdn.net/v2/jpg/00/89/55/15/500_F_89551596_LdHAZRwz3i4EM4J0NHNHy2hEUYDfXc0j.jpg',
                                                      imageBuilder: (context, imageBuilder) {
                                                        return Container(
                                                          width: 80,
                                                          height: 80,
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(100)),
                                                            image: DecorationImage(
                                                              image: imageBuilder,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      placeholder: (context, url) => Container(
                                                        width: 80,
                                                        height: 80,
                                                        child: Center(
                                                            child: CircularProgressIndicator()),
                                                      ),
                                                      errorWidget: (context, url, error) => Container(
                                                        width: 80,
                                                        height: 80,
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                            image: AssetImage('assets/activity_indicator.gif'),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  child: Center(
                                                    child: Text(cast.name!, style: TextStyle( color: Colors.black, fontSize: 9,),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  child: Center(
                                                    child: Text(cast.character!, style: TextStyle(color: Colors.black, fontSize: 9,),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                ],
                              ),
                          ),
                        ],
                      )
                      ),
                  );
                }else {
            return Center(
              child: CircularProgressIndicator(),
            );
              }
          }
        
        });
        
        }

      }




  