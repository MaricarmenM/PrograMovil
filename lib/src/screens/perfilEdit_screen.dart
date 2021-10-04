

import 'package:flutter/material.dart';
import 'package:practica2/src/database/database_profile.dart';
import 'package:practica2/src/models/perfil_model.dart';
import 'package:practica2/src/utils/color_settings.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatefulWidget {
  PerfilModel? dato;
  EditProfileScreen({ Key? key ,this.dato }) : super(key: key);
  
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  late DatabasePerfil _DatabasePerfil;

  TextEditingController _controllerNombre = TextEditingController();
  TextEditingController _controllerApellido1 = TextEditingController();
  TextEditingController _controllerApellido2 = TextEditingController();
  TextEditingController _controllerTelefono = TextEditingController();
  TextEditingController _controllerCorreo = TextEditingController();

  @override
  // ignore: must_call_super
  void initState(){
    if (widget.dato!=null) {
      _controllerNombre.text = widget.dato!.nombre!;
      _controllerApellido1.text = widget.dato!.apellido1!;
      _controllerApellido2.text=widget.dato!.apellido2!;
      _controllerTelefono.text=widget.dato!.telefono!;
      _controllerCorreo.text=widget.dato!.correo!;
      
    }
    _DatabasePerfil = DatabasePerfil();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorSettings.colorPrimary,
        title: widget.dato == null ? Text('Perfil de Usuario'): Text('Editar Perfil'),
      ),
      body: widget.dato == null ?
      Column(
        children: [
          _crearTextFieldFoto(),
          _crearTextFieldNombre(),
          SizedBox(height: 10,),
          _crearTextFieldApellido1(),
          _crearTextFieldApellido2(),
          _crearTextFieldTelefono(),
          _crearTextFieldCorreo(),
          ElevatedButton(
            onPressed: (){
              if(widget.dato==null){
                PerfilModel dato = PerfilModel(
                  nombre: _controllerNombre.text,
                  apellido1: _controllerApellido1.text,
                  apellido2: _controllerApellido2.text,
                  telefono: _controllerTelefono.text,
                  correo: _controllerCorreo.text
                );
                _DatabasePerfil.insert(dato.toMap()).then(
                  (value){
                    if (value>0) {
                     Navigator.pop(context);
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('La solicitud no se completo')));
                    }
                  }
                );
                }
            }, 
            child: Text('Guardar Datos'),
             
          )
        ],
      ):
      Column(
        children: [
          _crearTextFieldFoto(),
          _crearTextFieldNombre(),
          SizedBox(height: 10,),
          _crearTextFieldApellido1(),
          _crearTextFieldApellido2(),
          _crearTextFieldTelefono(),
          _crearTextFieldCorreo(),
          ElevatedButton(
            onPressed: (){
              if(widget.dato!=null){
                  PerfilModel dato = PerfilModel(
                    id: widget.dato!.id,
                    nombre: _controllerNombre.text,
                    apellido1: _controllerApellido1.text,
                    apellido2: _controllerApellido2.text,
                    telefono: _controllerTelefono.text,
                    correo: _controllerCorreo.text
                  );
                  _DatabasePerfil.update(dato.toMap()).then(
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
            }, 
            child: Text('Guardar Datos'),
            
          )
        ],
      ),
    );
  }

   Widget _crearTextFieldFoto(){
    return IconButton(
      onPressed: (){
         Navigator.pushNamed(context,'/agregarFoto');
      }, 
      icon: Icon(Icons.camera_alt_outlined));
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
      ),
      onChanged: (value){
        
      },
    );
  }
  Widget _crearTextFieldTelefono(){
    return TextField(
      controller: _controllerTelefono,
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        filled: true,
        icon: Icon(Icons.phone),
        hintText: 'Ingresa tu número de telefono',
        labelText: 'Número Telefonico *',
        prefixText: '+52 ',
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
      ),
      onChanged: (value){
        
      },
    );
  }

}