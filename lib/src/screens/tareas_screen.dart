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
         actions: [
           IconButton(
             onPressed: (){
               Navigator.pushNamed(context,'/tareasCompletas').whenComplete((){
                 setState(() {});
               });
             }, 
             icon: Icon(Icons.checklist_rounded),
             )
         ],
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
        return Future.delayed(Duration(seconds: 2),() {
          setState(() { });
          }
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
                    icon: Icon(Icons.more_vert),
                    onPressed: () {
                      showDialog(
                        context: context, 
                        builder: (BuildContext context){
                          return AlertDialog(
                            contentPadding: EdgeInsets.all(0),
                            content: SingleChildScrollView(
                              child:Column(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(
                                        context, 
                                        MaterialPageRoute(
                                            builder:(context)=> AgregarTareaScreen(tarea: tarea,)
                                        )
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(width: 1,color: Colors.grey)) 
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(' Editar Tarea')
                                            ),
                                          Icon(Icons.edit_rounded),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      showDialog(
                                          context: context,
                                          builder: (context){
                                            return AlertDialog(
                                              title: Text('Confirmación'),
                                              content: Text('Estas seguro de eliminar la tarea?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: (){
                                                    Navigator.pop(context);
                                                    _databaseHelper.deleteHW(tarea.id!).then(
                                                      (noRows){
                                                        if (noRows>0) {
                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                          SnackBar(content: Text('Registro eliminado')));
                                                          setState(() {});
                                                        }
                                                      }
                                                    );
                                                  },
                                                  child: Text('si')
                                                ),
                                                TextButton(
                                                  onPressed: (){
                                                    Navigator.pop(context);
                                                  }, 
                                                  child: Text('no')
                                                  )
                                              ],
                                            );
                                          }
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(width: 1,color: Colors.grey)),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text('Eliminar Tarea'),
                                            ),
                                          Icon(Icons.delete_rounded)
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                        tarea.entregada = 'SI';
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text('Confirmación'),
                                              content: Text(
                                                  'La tarea se marcara como entregada?'),
                                              actions: [
                                                TextButton(
                                                 onPressed: () {
                                                      Navigator.pop(context);
                                                      _databaseHelper
                                                          .updateHW(tarea.toMap())
                                                          .then((noRows) {
                                                        if (noRows > 0) {
                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                            SnackBar(
                                                                  content: Text('Tarea entregada con exito!!'))
                                                            );
                                                          setState(() {});
                                                        }
                                                      });
                                                    },
                                                    child: Text('OK')),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Cancelar')),
                                              ],
                                            );
                                          }).then((value) {
                                        setState(() {});
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(width: 1,color: Colors.grey)),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text('Entregar Tarea'),
                                            ),
                                          Icon(Icons.check_circle_sharp),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ) ,
                            ),
                          );
                        },
                     );
                    }),
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


