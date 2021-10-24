

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/perfil_model.dart';
import 'package:practica2/src/utils/color_settings.dart';
import 'dart:convert';

import 'package:practica2/src/utils/util_image.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatefulWidget {
  PerfilModel? dato;

  EditProfileScreen({ Key? key ,this.dato }) : super(key: key);
  
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  // ignore: non_constant_identifier_names
  late DatabaseHelper _databaseHelper;

  TextEditingController _controllerNombre = TextEditingController();
  TextEditingController _controllerApellido1 = TextEditingController();
  TextEditingController _controllerApellido2 = TextEditingController();
  TextEditingController _controllerTelefono = TextEditingController();
  TextEditingController _controllerCorreo = TextEditingController();

  String? imagen;
  final picker = ImagePicker();

   Future selImagen(op) async{
      var pickedFile;
      if (op==1) {
        // ignore: deprecated_member_use
        pickedFile= await picker.getImage(
          source:ImageSource.camera,
          maxWidth: 250.0,
          maxHeight: 250.0,);
      }else{
        // ignore: deprecated_member_use
        pickedFile= await picker.getImage(
          source:ImageSource.gallery,
          maxWidth: 250.0,
          maxHeight: 250.0,);
      }
      setState(() {
        if (pickedFile != null) {
         final imagenTemporal=File(pickedFile.path);
          imagen = UtilityImage.base64String(imagenTemporal.readAsBytesSync());

        }else{
          print('no hay imagen seleccionada');
        }
      });
      Navigator.of(context).pop();
    }

  @override
  // ignore: must_call_super
  void initState(){
    if (widget.dato!=null) {
      _controllerNombre.text = widget.dato!.nombre!;
      _controllerApellido1.text = widget.dato!.apellido1!;
      _controllerApellido2.text=widget.dato!.apellido2!;
      _controllerTelefono.text=widget.dato!.telefono!;
      _controllerCorreo.text=widget.dato!.correo!;
      imagen= widget.dato!.foto!;
    }
    _databaseHelper = DatabaseHelper();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorSettings.colorPrimary,
        title: widget.dato == null ? Text('Perfil de Usuario'): Text('Editar Perfil'),
      ),
      body: 
      
      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30,),
            imagen==null ? Center():Image.memory(
                base64Decode(imagen!),
                fit: BoxFit.fill,
              ),
             SizedBox(height: 10,),
            _crearTextFieldFoto(),
            SizedBox(height: 10,),
            _crearTextFieldNombre(),
            SizedBox(height: 10,),
            _crearTextFieldApellido1(),
            SizedBox(height: 10,),
            _crearTextFieldApellido2(),
            SizedBox(height: 10,),
            _crearTextFieldTelefono(),
            SizedBox(height: 10,),
            _crearTextFieldCorreo(),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: (){
              if (_controllerNombre.text != "" && _controllerNombre.text != " ") {
              if (_controllerApellido1.text != "" && _controllerApellido1.text != " ") {
              if (_controllerApellido2.text != "" && _controllerApellido2.text != " ") {
              if (_controllerTelefono.text != "" && _controllerTelefono.text != " ") {
                if (_controllerCorreo.text != "" && _controllerCorreo.text != " ") {
                      if(widget.dato==null){
                        PerfilModel dato = PerfilModel(
                          nombre: _controllerNombre.text,
                          apellido1: _controllerApellido1.text,
                          apellido2: _controllerApellido2.text,
                          telefono: _controllerTelefono.text,
                          correo: _controllerCorreo.text
                        );
                        _databaseHelper.insertUser(dato.toMap()).then(
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
                        PerfilModel dato = PerfilModel(
                            id: widget.dato!.id,
                            nombre: _controllerNombre.text,
                            apellido1: _controllerApellido1.text,
                            apellido2: _controllerApellido2.text,
                            telefono: _controllerTelefono.text,
                            correo: _controllerCorreo.text,
                            foto: imagen
                          );
                          _databaseHelper.updateUser(dato.toMap()).then(
                            (value) {
                              if (value >0) {
                                Navigator.pop(context);
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('La solicitud no se completo'))
                                  );
                                }
                            });
                        }
                     }
                    }
                  }
                 }
                }
               },
              child: Text('Guardar Datos'),
            )
          ],
        ),
      ),
    );
  }
//WIDGETS PARA EL FORMULARIO 
   Widget _crearTextFieldFoto(){
    return ElevatedButton(
    style: ElevatedButton.styleFrom(primary: ColorSettings.colorPrimary),
    onPressed:(){
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
                      selImagen(1);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1,color: Colors.grey))
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text('Tomar Fotografia'),
                            )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      selImagen(2);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1,color: Colors.grey)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text('Ir a la galeria'),
                            )
                        ],
                      ),
                    ),
                  )
                ],
              ) ,
              ),
          );
        }
        );
    }, 
    child: Text('Selecciona una imagen'),
    );
 }
  Widget _crearTextFieldNombre(){
    return TextFormField(
      controller: _controllerNombre,
      textCapitalization: TextCapitalization.words,
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        filled: true,
        icon: Icon(Icons.person),
        hintText: 'Ingresa tu nombre',
        labelText: 'Nombre(s) *',
        errorText: "Campo obligatorio"
      ),
      onChanged: (value){
      },
    );
  }
  
  Widget _crearTextFieldApellido1(){
    return TextField(
      controller: _controllerApellido1,
      textCapitalization: TextCapitalization.words,
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        filled: true,
        hintText: 'Ingres tu apellido paterno',
        labelText: 'Apellido Paterno *',
        errorText: "Campo obligatorio"
      ),
      onChanged: (value){
        
      },
    );
  }
   Widget _crearTextFieldApellido2(){
    return TextField(
      controller: _controllerApellido2,
      textCapitalization: TextCapitalization.words,
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        filled: true,
      //  icon: Icon(Icons.person),
        hintText: 'Ingres tu apellido materno',
        labelText: 'Apellido Materno',
        errorText: "Campo obligatorio"
      ),
      onChanged: (value){
      },
    );
  }
  Widget _crearTextFieldTelefono(){
    return TextField(
      controller: _controllerTelefono,
      maxLength: 10,
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        filled: true,
        icon: Icon(Icons.phone),
        hintText: 'Ingresa tu número de telefono',
        labelText: 'Número Telefonico *',
        prefixText: '+52 ',
        errorText: "Campo obligatorio"
      ),
      onChanged: (value){
      },
    );
  }

  Widget _crearTextFieldCorreo(){
    return TextField(
      controller: _controllerCorreo,
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        filled: true,
        icon: Icon(Icons.email),
        hintText: 'Dirección de correo',
        labelText: 'E-mail',
        errorText: "Campo obligatorio"
      ),
      onChanged: (value){
      },
    );
  }

}