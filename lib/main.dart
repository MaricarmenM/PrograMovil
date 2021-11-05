import 'package:flutter/material.dart';
import 'package:practica2/src/screens/News/detail_screen.dart';
import 'package:practica2/src/screens/News/news_screen.dart';
import 'package:practica2/src/screens/Notas/AgregarNotaScreen.dart';
import 'package:practica2/src/screens/Tareas/Tareas_completas_screen.dart';
import 'package:practica2/src/screens/Tareas/agregar_tareas_screen.dart';
import 'package:practica2/src/screens/intensiones_screen.dart';
import 'package:practica2/src/screens/login_screen/opcion1_screen.dart';
import 'package:practica2/src/screens/movies_screens/detail_screen.dart';
import 'package:practica2/src/screens/movies_screens/popular_screen.dart';
import 'package:practica2/src/screens/Notas/notas_screen.dart';
import 'package:practica2/src/screens/Perfil/perfilEdit_screen.dart';
import 'package:practica2/src/screens/Perfil/profile_screen.dart';
import 'package:practica2/src/screens/splash_screen.dart';
import 'package:practica2/src/screens/Tareas/tareas_screen.dart';
import 'package:practica2/src/views/fav_movies.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/opc1'         :(BuildContext context) => Opcion1Screen(),
        '/intensiones'  :(BuildContext context) => IntensionesScreen(),
        '/notas'        :(BuildContext context) => NotasScreen(),
        '/agregar'      :(BuildContext cotext)  => AgregarNotaScreen(),
        '/perfil'       :(BuildContext context) => UserProfileScreen(),
        '/perfilEdit'   :(BuildContext context) => EditProfileScreen(),
        '/movie'        :(BuildContext context) => PopularScreen(),
        '/tareas'       :(BuildContext context)=> TareasScreen(),
       '/crudTareas'    :(BuildContext context)=> AgregarTareaScreen(),
       '/tareasCompletas'   :(BuildContext context)=> TareasEntregadasScreen(),
       '/detail'            :(BuildContext context)=> DetailScreen(),
       '/favMovies'   :(BuildContext context)=> FavMoviesScreen(),
       '/noticias'        :(BuildContext context) => NewsScreen(),
      '/detailNews'        :(BuildContext context) => NewsDetailScreen(),
      },
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}