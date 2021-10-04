import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practica2/src/utils/color_settings.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
      GestureDetector iconoPerfil = GestureDetector(
        child: Image(image:  AssetImage('assets/user.jpg')),
        onTap: (){
          Navigator.pop(context);
          Navigator.pushNamed(context,'/perfil');
        },
      );
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text('DASHBOARD'),
        backgroundColor: ColorSettings.colorPrimary,
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text('Maricarmen Mendoza Herrera'), 
                accountEmail: Text('17030815@itcelaya.edu.mx'),
                currentAccountPicture: CircleAvatar(
                  child: iconoPerfil,
                  backgroundColor: Colors.white,  
                ),
                decoration: BoxDecoration(
                  color: ColorSettings.colorPrimary
                ),
              ),
               
                ListTile(
                  title: Text('Propinas'),
                  subtitle: Text('calculadora de propina'),
                  leading: Icon(Icons.monetization_on_outlined),
                  trailing: Icon(Icons.chevron_right),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/opc1');
                  },
                ),
                ListTile(
                  title: Text('Intensiones'),
                  subtitle: Text('itensiones implicitas'),
                  leading: Icon(Icons.phone_android),
                  trailing: Icon(Icons.chevron_right),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.pushNamed(context,'/intensiones');
                  },
                ),
                 ListTile(
                  title: Text('Notas'),
                  subtitle: Text('CRUD Notas'),
                  leading: Icon(Icons.note),
                  trailing: Icon(Icons.chevron_right),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.pushNamed(context,'/notas');
                  },
                ),
                ListTile(
                  title: Text('Movies'),
                  subtitle: Text('Prueba API REST'),
                  leading: Icon(Icons.movie),
                  trailing: Icon(Icons.chevron_right),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.pushNamed(context,'/movie');
                  },
                )
            ],
          ),
        ),
      ),
    );
  }
}