import 'package:flutter/material.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/tareas_model.dart';
import 'package:practica2/src/screens/Tareas/agregar_tareas_screen.dart';
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
        future: _databaseHelper.getAllHWSinEntregar(),
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
            color: DateTime.now().isAfter(DateTime.parse(tarea.fechaEntrega!))? Colors.red[400]:Colors.white,
            child: Column(
              children: [
                Text(tarea.nomTarea!, style: TextStyle(color: (DateTime.now().isAfter(DateTime.parse(tarea.fechaEntrega!)))? Colors.white:Colors.black),),
                Text(tarea.descTarea!, style: TextStyle(color: (DateTime.now().isAfter(DateTime.parse(tarea.fechaEntrega!)))? Colors.white:Colors.black),),
                Text(tarea.fechaEntrega!, style: TextStyle(color: (DateTime.now().isAfter(DateTime.parse(tarea.fechaEntrega!)))? Colors.white:Colors.black),),
                Text(tarea.entregada!, style: TextStyle(color: (DateTime.now().isAfter(DateTime.parse(tarea.fechaEntrega!)))? Colors.white:Colors.black),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                   ElevatedButton(
                        style: ElevatedButton.styleFrom(minimumSize: const Size(350, 20),primary: ColorSettings.colorPrimary),
                        onPressed: (){
                          tarea.entregada = "Entregada";
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
                                      },
                                      child: Text('Cancelar')),
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
                                ],
                              );
                            }).then((value) {
                          setState(() {});
                        });
                      },
                      child: 
                      Text('Entregar')
                    ),
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
                                                }, 
                                                child: Text('no')
                                                ),
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


