import 'package:flutter/material.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/tareas_model.dart';
import 'package:practica2/src/utils/color_settings.dart';

class TareasEntregadasScreen extends StatefulWidget {
  const TareasEntregadasScreen({ Key? key }) : super(key: key);

  @override
  _TareasEntregadasScreenState createState() => _TareasEntregadasScreenState();
}

class _TareasEntregadasScreenState extends State<TareasEntregadasScreen> {

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
         title: Text('Tareas Entregadas'),
      ),
      body: FutureBuilder(
        future: _databaseHelper.getAllHWEntregadas(),
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
                Text(tarea.fechaEntrega!,),
                Text(tarea.entregada!,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   ElevatedButton(
                      style: ElevatedButton.styleFrom(minimumSize: const Size(400, 20),primary: ColorSettings.colorSec),
                        onPressed: (){
                          tarea.entregada = "Sin Entregar";
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Confirmación'),
                                content: Text(
                                    'Desea anular la entrega?'),
                                actions: [
                                   TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: 
                                      Text('Cancelar')),
                                  TextButton(
                                    onPressed: () {
                                        Navigator.pop(context);
                                        _databaseHelper
                                            .updateHW(tarea.toMap())
                                            .then((noRows) {
                                          if (noRows > 0) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                    content: Text('Entrega anulada!!'))
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
                      child:  Text('Anular Entrega'),
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


