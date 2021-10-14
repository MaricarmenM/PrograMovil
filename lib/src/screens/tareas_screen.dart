import 'package:flutter/material.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/tareas_model.dart';
import 'package:practica2/src/screens/agregar_tareas_screen.dart';
import 'package:practica2/src/utils/color_settings.dart';

class TareasScreen extends StatefulWidget {
  const TareasScreen({ Key? key }) : super(key: key);

  @override
  _TareasScreenState createState() => _TareasScreenState();
}

class _TareasScreenState extends State<TareasScreen> {

  // ignore: non_constant_identifier_names
  late DatabaseHelper _databaseHelper;

  @override
  void initState(){
    super.initState();
    _databaseHelper = DatabaseHelper();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: ColorSettings.colorPrimary,
         title: Text('Tareas'),
      ),
      body: FutureBuilder(
        future: _databaseHelper.getAllHW(),
        builder: (BuildContext context, AsyncSnapshot<List<TareasModel>>snapshot){
          if (snapshot.hasError) {
            return Center(child: Text('Ocurrio un error en la peticion'),);
          }else{
            if (snapshot.connectionState == ConnectionState.done) {
              return _listadoTareas(snapshot.data!);
            } else {
              return Center(child: CircularProgressIndicator(),);
            }   
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context,'/crudTareas').whenComplete((){
                 setState(() {});
               });
        },   
        child: const Icon(Icons.add),
      ),
    );
  }
  Widget _listadoTareas(List<TareasModel> tareas){
    return RefreshIndicator(
      onRefresh: (){
        return Future.delayed(
          Duration(seconds: 2),
        (){setState(() { });}
        );
      },
      child: ListView.builder(
        itemBuilder: (BuildContext context, index){
          TareasModel tarea = tareas[index];
          return Card(
            child: Column(
              children: [
                Text(tarea.nomTarea!,),
                Text(tarea.descTarea!),
                Text(tarea.fechaEntrega!),
                Text(tarea.entregada!),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: (){
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                           builder:(context)=> AgregarTareaScreen(tarea: tarea,)
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
        itemCount: tareas.length,
      ),
    );
  }
}


