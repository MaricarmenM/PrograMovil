import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavMoviesScreen extends StatefulWidget {
  const FavMoviesScreen({ Key? key }) : super(key: key);

  @override
  _FavMoviesScreenState createState() => _FavMoviesScreenState();
}

class _FavMoviesScreenState extends State<FavMoviesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Favorite Movies'),
      ),
      body: Container(
        
      ),
    );
  }
}