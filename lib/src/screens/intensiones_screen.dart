import 'package:flutter/material.dart';
import 'package:practica2/src/utils/color_settings.dart';
import 'package:url_launcher/url_launcher.dart';

class IntensionesScreen extends StatefulWidget {
  const IntensionesScreen({ Key? key }) : super(key: key);

  @override
  _IntensionesScreenState createState() => _IntensionesScreenState();
}

class _IntensionesScreenState extends State<IntensionesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('intensiones implicitas'),
        backgroundColor: ColorSettings.colorPrimary,
      ),
      body: ListView(
        children: [
        Card(
          elevation: 8.0,
          child: ListTile(
            tileColor: Colors.white60,
            title: Text('Abrir pagia web'),

            subtitle: Row(
              children: [
                Icon(Icons.touch_app_rounded, size: 18.0,color: Colors.red,),
                Text('https://celaya.tecnm.mx'),
              ],
            ),
            leading: Container(
              height: 40.0,
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(Icons.language, color: Colors.black,),
              decoration: BoxDecoration(
                border: Border(right: BorderSide(width: 1.0))
              ),
            ),
            trailing: Icon(Icons.chevron_right),
            onTap: _abrirWeb,
          ),
        ),
                Card(
          elevation: 8.0,
          child: ListTile(
            tileColor: Colors.white60,
            title: Text('Llamada telefonica'),

            subtitle: Row(
              children: [
                Icon(Icons.touch_app_rounded, size: 18.0,color: Colors.red,),
                Text('cel: 4111777247'),
              ],
            ),
            leading: Container(
              height: 40.0,
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(Icons.call_made,color: Colors.black,),
              decoration: BoxDecoration(
                border: Border(right: BorderSide(width: 1.0))
              ),
            ),
            trailing: Icon(Icons.chevron_right),
            onTap: _llamadaTelefonica,
          ),
        ),
                Card(
          elevation: 8.0,
          child: ListTile(
            tileColor: Colors.white60,
            title: Text('Enviar sms'),

            subtitle: Row(
              children: [
                Icon(Icons.touch_app_rounded, size: 18.0,color: Colors.red,),
                Text('cel: 4111777247'),
              ],
            ),
            leading: Container(
              height: 40.0,
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(Icons.sms_sharp,color: Colors.black,),
              decoration: BoxDecoration(
                border: Border(right: BorderSide(width: 1.0))
              ),
            ),
            trailing: Icon(Icons.chevron_right),
            onTap: _enviarSMS,
          ),
        ),
                Card(
          elevation: 8.0,
          child: ListTile(
            tileColor: Colors.white60,
            title: Text('Enviar email'),

            subtitle: Row(
              children: [
                Icon(Icons.touch_app_rounded, size: 18.0,color: Colors.red,),
                Text('To: 17030815@itcelaya.edu.mx'),
              ],
            ),
            leading: Container(
              height: 40.0,
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(Icons.email_rounded, color: Colors.black,),
              decoration: BoxDecoration(
                border: Border(right: BorderSide(width: 1.0))
              ),
            ),
            trailing: Icon(Icons.chevron_right),
            onTap: _enviarEmail,
          ),
        ),
                Card(
          elevation: 8.0,
          child: ListTile(
            tileColor: Colors.white60,
            title: Text('Tomar Fotografia'),

            subtitle: Row(
              children: [
                Icon(Icons.touch_app_rounded, size: 18.0,color: Colors.red,),
                Text(''),
              ],
            ),
            leading: Container(
              height: 40.0,
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(Icons.camera_enhance_rounded, color: Colors.black,),
              decoration: BoxDecoration(
                border: Border(right: BorderSide(width: 1.0))
              ),
            ),
            trailing: Icon(Icons.chevron_right),
            onTap: (){},
          ),
        )
        ] ,
      
      ),
    );
  }
// variable privada cuando comienza con _
  _abrirWeb() async {
    const url = "https://celaya.tecnm.mx";
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  _llamadaTelefonica () async {
    const url = "tel: 4111117247";
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  _enviarSMS() async {
    const url = "sms: 4111777247";
    if (await canLaunch(url)) {
     await launch(url);
    }
  }

  _enviarEmail() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: '17030815@itcelaya.edu.mx',
      query: "subject=Saudos&body=Bienvenido :)"
    );
    var email = params.toString();
    if (await canLaunch(email)) {
      await launch(email);
    }
  }

  tomarFoto(){

  }

}