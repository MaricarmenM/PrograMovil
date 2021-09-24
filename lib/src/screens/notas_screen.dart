import 'package:flutter/material.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/notas_model.dart';
import 'package:practica2/src/utils/color_settings.dart';

class NotasScreen extends StatefulWidget {
  const NotasScreen({ Key? key }) : super(key: key);

  @override
  _NotasScreenState createState() => _NotasScreenState();
}

class _NotasScreenState extends State<NotasScreen> {
  
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
         title: Text('GEstion de Notas'),
         actions: [
           IconButton(
             onPressed: (){
               Navigator.pushNamed(context,'/agregar');
             }, 
             icon: Icon(Icons.note_add)
             )
         ],
      ),
      body: FutureBuilder(
        future: _databaseHelper.getAllNotes(),
        builder: (BuildContext context, AsyncSnapshot<List<NotasModel>>snapshot){
          if (snapshot.hasError) {
            return Center(child: Text('Ocurrio un error en la peticion'),);
          }else{
            if (snapshot.connectionState == ConnectionState.done) {
              return _listadoNotas(snapshot.data!);
            } else {
              return Center(child: CircularProgressIndicator(),);
            }   
          }
        },
      ),
    );
  }
  Widget _listadoNotas(List<NotasModel> notas){
    return ListView.builder(
      itemBuilder: (BuildContext context, index){
        NotasModel nota = notas[index];
        return Card(
          child: Column(
            children: [
              Text(nota.titulo!, style: TextStyle(fontWeight: FontWeight.bold),),
              Text(nota.detalle)
            ],
          ),
        );
      },
      itemCount: notas.length,
    );
  }
}