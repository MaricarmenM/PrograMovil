import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/movies%20models/popular_movies_model.dart';

class CardPopularView extends StatefulWidget { 
   final PopularMoviesModel popular;
  const CardPopularView({ Key? key,required this.popular }) : super(key: key);

  @override
  _CardPopularViewState createState() => _CardPopularViewState();
}

class _CardPopularViewState extends State<CardPopularView> {
  @override
  Widget build(BuildContext context) {

    return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black87,
                offset: Offset(0.0,0.5),
                blurRadius: 2.5
              )
            ]
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                child: GestureDetector(
                    child: FadeInImage(
                          placeholder: AssetImage('assets/activity_indicator.gif'),
                          image: NetworkImage('https://image.tmdb.org/t/p/w500/${widget.popular.backdropPath}'),
                          fadeInDuration: Duration(milliseconds: 200),
                        ),
                     onTap: (){
                        Navigator.pushNamed(
                            context, '/detail',
                              arguments: {
                                'id':widget.popular.id,
                                'title' : widget.popular.title,
                                'overview':widget.popular.overview,
                                'posterpath': widget.popular.posterPath,
                                'backdrop':widget.popular.backdropPath,
                                'trailerId':widget.popular.trailerId
                              }
                          );
                      },
                ),
              ),
              Opacity(
                opacity: .8,
                child: Container(
                  padding: EdgeInsets.only(left: 10.0),
                  height: 60,
                  color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(widget.popular.title!,style: TextStyle(color: Colors.white,fontSize: 15.0),),
                    ],
                  ),
                ),
              ),
            ],
          )
        )
        );
  }

}
