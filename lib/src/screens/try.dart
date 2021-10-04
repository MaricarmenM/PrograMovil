import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practica2/src/utils/color_settings.dart';
import 'package:image_picker/image_picker.dart';

class TomarFoto extends StatefulWidget {
  const TomarFoto({ Key? key }) : super(key: key);

  @override
  _TomarFotoState createState() => _TomarFotoState();
}

class _TomarFotoState extends State<TomarFoto> {
  File? imagen;
  final picker = ImagePicker();

   Future selImagen(op) async{
      var pickedFile;
      if (op==1) {
        pickedFile= await picker.getImage(source:ImageSource.camera);
      }else{
        pickedFile= await picker.getImage(source:ImageSource.gallery);
      }
      setState(() {
        if (pickedFile != null) {
          imagen=File(pickedFile.path);
        }else{
          print('no hay imagen seleccionada');
        }
      });
      Navigator.of(context).pop();
    }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text('Selecciona imagen'),
         backgroundColor: ColorSettings.colorPrimary,
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                ElevatedButton(
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
                                      border: Border(bottom: BorderSide(width: 1,color: Colors.grey))
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
                ),
                SizedBox(height: 30,),
                imagen==null ? Center():Image.file(imagen!)
              ],
            ),
          )
        ],
      ),
    );
  }
}