import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practica2/src/utils/color_settings.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
               // currentAccountPicture: CircleAvatar(
                 // child: Image.asset('assets/fondo.jpeg')
                  //child: Image.network('https://www.brang.mx/admin/img/user.png'),
                //),
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
                )
            ],
          ),
        ),
      ),
    );
  }
}