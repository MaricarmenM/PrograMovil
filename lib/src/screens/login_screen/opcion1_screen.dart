import 'package:flutter/material.dart';
import 'package:practica2/src/screens/dashboard_screen.dart';
import 'package:practica2/src/utils/color_settings.dart';

class Opcion1Screen extends StatefulWidget {
  const Opcion1Screen({ Key? key }) : super(key: key);

  @override
  _Opcion1ScreenState createState() => _Opcion1ScreenState();
}

class _Opcion1ScreenState extends State<Opcion1Screen> {
  
  final myController = TextEditingController();

  @override
  void dispose(){
    myController.dispose();
    super.dispose();
  }
  
  
  @override
  Widget build(BuildContext context) {
      TextFormField pago = TextFormField(
      controller: myController,
      maxLength: 10,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'EL MONTO A PAGAR ES:',
        hintText: 'Introduce el monto a pagar',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20)
        ), 
        contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical:5, )
      ),
    );
    ElevatedButton cuadroDialogo = ElevatedButton(
         style: ElevatedButton.styleFrom(primary: ColorSettings.colorPrimary),
          onPressed: () {
            if (myController.text!="") {

            showDialog<String>(
              context: context,
              builder: (BuildContext context) {
                var monto = double.parse(myController.text);
                double porcentaje=0.10;

                dynamic propina = (monto*(porcentaje)).round();
                double total =monto+propina;

                return AlertDialog(
                title: const Text('DETALLE DE PAGO...'),
                content: new Text('Monto: $monto MXN \n\nPropina: $propina MXN \n\nTotal: $total MXN',
                        style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold)
                ),
                
                actions: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: ColorSettings.colorPrimary),
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: ColorSettings.colorPrimary),
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
              );
              },
            );
            }
          },
          child: const Text('CALCULAR'),
      );
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          child: Scaffold(
            appBar: AppBar(title: Text('CALCULADORA DE PROPINAS'),
            backgroundColor: ColorSettings.colorPrimary,
            ),
          )
        ),
         Card(
          margin: EdgeInsets.only(left: 15,right: 15,bottom:250),
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