import 'package:flutter/material.dart';
import 'package:practica2/src/screens/dashboard_screen.dart';
import 'package:practica2/src/utils/color_settings.dart';

class Opcion1Screen extends StatelessWidget {
  const Opcion1Screen({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    TextFormField pago = TextFormField(
      maxLength: 10,
      decoration: InputDecoration(
        labelText: 'EL MONTO TOTAL A PAGAR ES:',
        hintText: 'Introduce el monto a pagar',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20)
        ), 
        contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical:5, )
      ),
    );
    ElevatedButton cuadroDialogo = ElevatedButton(
         style: ElevatedButton.styleFrom(primary: ColorSettings.coloButton),
          onPressed: () {
            // The function showDialog<T> returns Future<T>.
            // Use Navigator.pop() to return value (of type T).
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('La propina debe ser:'),
                content: const Text(' MXN',style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                actions: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: ColorSettings.coloButton),
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: ColorSettings.coloButton),
                    onPressed: (){
                      Future.delayed(Duration(seconds: 1),(){
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => DashBoardScreen())
                          );
                      });
                    }, child:  
                        Text('OK')
                  ),
                ],
              ),
            );
          },
          child: const Text('CALCULAR'),
      );
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
         Card(
          margin: EdgeInsets.only(left: 15,right: 15,bottom:300),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                pago, 
                cuadroDialogo,
              ],
            ),
          ),
        ),
      ]
    );
  }
}
















