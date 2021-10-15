import 'package:flutter/material.dart';
import 'package:practica2/src/screens/AgregarNotaScreen.dart';
import 'package:practica2/src/screens/Tareas_completas_screen.dart';
import 'package:practica2/src/screens/agregar_tareas_screen.dart';
import 'package:practica2/src/screens/intensiones_screen.dart';
import 'package:practica2/src/screens/login_screen/opcion1_screen.dart';
import 'package:practica2/src/screens/movies_screens/detail_screen.dart';
import 'package:practica2/src/screens/movies_screens/popular_screen.dart';
import 'package:practica2/src/screens/notas_screen.dart';
import 'package:practica2/src/screens/perfilEdit_screen.dart';
import 'package:practica2/src/screens/profile_screen.dart';
import 'package:practica2/src/screens/splash_screen.dart';
import 'package:practica2/src/screens/tareas_screen.dart';

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
       '/detail' :(BuildContext context)=> DetailScreen(),
      // '/crudTareas'   :(BuildContext context)=> BottomTabbarExample(),
      },
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}