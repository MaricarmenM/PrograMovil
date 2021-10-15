import 'package:flutter/material.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/tareas_model.dart';
import 'package:practica2/src/screens/tareas_screen.dart';
import 'package:practica2/src/utils/color_settings.dart';

// ignore: must_be_immutable
class AgregarTareaScreen extends StatefulWidget {
  TareasModel? tarea;
  AgregarTareaScreen({ Key? key ,this.tarea }) : super(key: key);

  @override
  _AgregarTareaScreenState createState() => _AgregarTareaScreenState();
}

class _AgregarTareaScreenState extends State<AgregarTareaScreen> {

  late DatabaseHelper _databaseHelper;

  TextEditingController _controllerNombre = TextEditingController();
  TextEditingController _controllerDescripcion = TextEditingController();
  TextEditingController _controllerFechaEntrega = TextEditingController();
  TextEditingController _controllerEntregada = TextEditingController();

  @override
  // ignore: must_call_super
  void initState(){
    if (widget.tarea!=null) {
      _controllerNombre.text = widget.tarea!.nomTarea!;
      _controllerDescripcion.text = widget.tarea!.descTarea!;
      _controllerFechaEntrega.text= widget.tarea!.fechaEntrega!;
      _controllerEntregada.text=widget.tarea!.entregada!;
    }
    _databaseHelper = DatabaseHelper();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorSettings.colorPrimary,
        title: widget.tarea == null ? Text('Agregar Tarea'): Text('Editar Tarea'),
        actions: [
          IconButton(
             onPressed: (){
                if(widget.tarea==null){
                TareasModel tarea = TareasModel(
                  nomTarea: _controllerNombre.text,
                  descTarea: _controllerDescripcion.text,
                  fechaEntrega: _controllerFechaEntrega.text,
                  entregada: _controllerEntregada.text,
                );
                _databaseHelper.insertHW(tarea.toMap()).then(
                  (value){
                    if (value>0) {
                      Navigator.pop(context);
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('La solicitud no se completo')));
                    }
                  }
                  );
                }else{
                  TareasModel tarea = TareasModel(
                      id: widget.tarea!.id,
                      nomTarea: _controllerNombre.text,
                      descTarea: _controllerDescripcion.text,
                      fechaEntrega: _controllerFechaEntrega.text,
                      entregada: _controllerEntregada.text,
                  );
                  _databaseHelper.updateHW(tarea.toMap()).then(
                    (value) {
                      if (value >0) {
                        Navigator.pop(context);
                         SnackBar(content: Text('Tarea editada con exito'));
                          setState(() {});
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('La solicitud no se completo'))
                          );
                        }
                    });
                }
             },
             icon:Icon(Icons.send_outlined)
          ),
        ],
      ),
      body:  SingleChildScrollView (
        child: Column(
          children: [
            SizedBox(height: 10,),
            _crearTextFieldNombre(),
            SizedBox(height: 10,),
            _crearTextFieldDescripcion(),
            SizedBox(height: 10,),
            _crearTextFieldFechaEntrega(),
            SizedBox(height: 10,),
            _crearTextFieldEntregada(),
          ],
        ),
      ),
    );
  }

   Widget _crearTextFieldNombre(){
    return TextFormField(
      controller: _controllerNombre,
      textCapitalization: TextCapitalization.words,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Ingresa el nombre de la tarea',
        labelText: 'Nombre Tarea *',
      ),
      onChanged: (value){
      },
    );
  }

  Widget _crearTextFieldDescripcion(){
    return TextFormField(
      controller: _controllerDescripcion,
      maxLines: 8,
      textCapitalization: TextCapitalization.words,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Ingresa el decripcion de la tarea',
        labelText: 'Descripcion Tarea ',
      ),
      onChanged: (value){
      }
    );
  }

   Widget _crearTextFieldFechaEntrega(){
    return TextFormField(
      controller: _controllerFechaEntrega,
      textCapitalization: TextCapitalization.words,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Ingresa la fecha de entrega',
        labelText: 'Fecha de Entrega *',
      ),
      onChanged: (value){
      },
    );
  }

     Widget _crearTextFieldEntregada(){
    return TextFormField(
      controller: _controllerEntregada,
      textCapitalization: TextCapitalization.words,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Ingresa el estatus de entrega',
        labelText: 'Estatus de Entrega *',
      ),
      onChanged: (value){
      },
    );
  }



  

}