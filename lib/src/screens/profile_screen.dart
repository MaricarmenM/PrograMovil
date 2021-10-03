import 'package:flutter/material.dart';
import 'package:practica2/src/database/database_profile.dart';
import 'package:practica2/src/models/perfil_model.dart';
import 'package:practica2/src/screens/perfilEdit_screen.dart';
import 'package:practica2/src/utils/color_settings.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({ Key? key }) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {

  late DatabasePerfil _DatabasePerfil;

  @override
  void initState(){
    super.initState();
    _DatabasePerfil = DatabasePerfil();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: ColorSettings.colorPrimary,
         title: Text('Perfil'),
         actions: [
           IconButton(
             onPressed: (){
               Navigator.pushNamed(context,'/perfilEdit');
             }, 
             icon: Icon(Icons.note_add)
             )
         ],
      ),
      body: FutureBuilder(
        future: _DatabasePerfil.getAllUsers(),
        builder: (BuildContext context, AsyncSnapshot<List<PerfilModel>>snapshot){
          if (snapshot.hasError) {
            return Center(child: Text('Ocurrio un error en la peticion'),);
          }else{
            if (snapshot.connectionState == ConnectionState.done) {
              return _perfilesResgitrados(snapshot.data!);
            } else {
              return Center(child: CircularProgressIndicator(),);
            }   
          }
        },
      ),
    );
  }
  Widget _perfilesResgitrados(List<PerfilModel> datos){
    return RefreshIndicator(
      onRefresh: (){
        return Future.delayed(
          Duration(seconds: 2),
        (){setState(() { });}
        );
      },
      child: ListView.builder(
        itemBuilder: (BuildContext context, index){
          PerfilModel dato = datos[index];
          return Card(
            child: Column(
              children: [
                Text(dato.nombre!,),
                Text(dato.apellido1!),
                Text(dato.apellido2!),
                Text(dato.telefono!),
                Text(dato.correo!),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: (){
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder:(context)=> EditProfileScreen(dato: dato,)
                          )
                        );
                      },
                      icon: Icon(Icons.edit),
                      iconSize: 18, 
                    ),
                  ],
                )
              ],
            ),
          );
        },
        itemCount: datos.length,
      ),
    );
  }
}


