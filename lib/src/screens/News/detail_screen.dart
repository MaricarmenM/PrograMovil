import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practica2/src/utils/color_settings.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

  final noticia = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.blueGrey,
        title: Text('${noticia['name']}',
                style: TextStyle(
                  color: Colors.white,
                    fontSize: 16.0,
                ),
              ), 
      ),
      body:SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  Opacity(
                    opacity: .9,
                    child: Container(
                        height: 290.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(noticia['urlToImage']), fit: BoxFit.cover),
                        ),
                      ),
                  ),
                   Padding(
                    padding: const EdgeInsets.all(7.0),
                     child: Opacity(
                       opacity: .5,
                       child: Container(
                          padding: EdgeInsets.only(left: 15.0),
                          height: 65,
                          color: Colors.black,
                          child: Text(noticia['title'].toUpperCase(),
                            textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white
                              ),
                            ),
                       ),
                     ),
                   ),
                ],
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8.0,
                      ),
                      Column(
                        children: [
                          Text('Date: ${noticia['publishedAt']}',
                            style: TextStyle(
                              color: Colors.black87,
                               fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                       SizedBox(
                        height: 18.0,
                      ),
                      Text(
                        noticia['description'],
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        noticia['content'],
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                     
                       Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text('By: ${noticia['author']}'.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 13.0,
                                  color: Colors.black54,
                                  ),
                              ),
                            SizedBox(height: 10.0,),
                          ],
                        ),
                      ),
                                  
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        padding: EdgeInsets.all(6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(primary: ColorSettings.colorNews),
                              onPressed: () async {
                                final FullNew = '${noticia['url']}';
                                if (await canLaunch(FullNew)) {
                                  await launch(FullNew);
                                }
                              },
                              child: Text('READ MORE ...',
                                style: TextStyle(
                                  fontSize: 15.0,
                                ),
                              )
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
