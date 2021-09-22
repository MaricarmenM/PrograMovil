import 'package:flutter/material.dart';
import 'package:practica2/src/screens/intensiones_screen.dart';
import 'package:practica2/src/screens/login_screen/opcion1_screen.dart';
import 'package:practica2/src/screens/notas_screen.dart';
import 'package:practica2/src/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/opc1' :(BuildContext context)=> Opcion1Screen(),
        '/intensiones':(BuildContext context) => IntensionesScreen(),
        '/notas':(BuildContext context)=> NotasScreen()
      },
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}