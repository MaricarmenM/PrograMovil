



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practica2/src/models/news%20models/details_model.dart';

class CardNewsView extends StatefulWidget { 
   final DetailNewsModel news;
  const CardNewsView({ Key? key,required this.news }) : super(key: key);

  @override
  _CardNewsViewState createState() => _CardNewsViewState();
}

class _CardNewsViewState extends State<CardNewsView> {
  @override
  Widget build(BuildContext context) {

    return Container(
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.blueGrey,
              )
            ]
          ),
          child: Column (
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200.0,
              width: double.infinity,
              child: GestureDetector(
                child: Image(
                  image: NetworkImage('${widget.news.urlToImage != null ? widget.news.urlToImage
                                          :'https://as2.ftcdn.net/v2/jpg/00/89/55/15/500_F_89551596_LdHAZRwz3i4EM4J0NHNHy2hEUYDfXc0j.jpg' }'
                      ),
                ),
                 onTap: (){
                    Navigator.pushNamed(
                        context, '/detailNews',
                          arguments: {
                            'id':widget.news.source!.id,
                            'name':widget.news.source!.name,
                            'title':widget.news.title,
                            'urlToImage':widget.news.urlToImage,
                            'author':widget.news.author,
                            'publishedAt':widget.news.publishedAt,
                            'content':widget.news.content,
                            'url':widget.news.url,
                            'description':widget.news.description!
                          }
                      );
                  },
              ),
            ),
            SizedBox( height: 5.0 ),
            Text(widget.news.title!,
             textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white
              ),
            ),
            SizedBox( height: 5.0 ),
            Text('Author(s):  ${widget.news.author !=null ? widget.news.author : 'UnKnow'}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.0,
                color: Colors.white70,
              ),
            ),
          ]
        ),
      );    
  }

}