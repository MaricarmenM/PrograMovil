
class PerfilModel {
  int? id;
  String? nombre;
  String? apellido1;
  String? apellido2;
  String? telefono;
  String? correo;

  PerfilModel({this.id,this.nombre,this.apellido1,this.apellido2,this.telefono,this.correo});

  //Map-> objetc
  factory PerfilModel.fromMap(Map<String,dynamic> map){
    return PerfilModel(
      id: map['id'],
      nombre: map['nombre'],
      apellido1: map['apellido1'],
      apellido2: map['apellido2'],
      telefono: map['telefono'],
      correo: map['correo']
      
    );
  }
  //object->map
  Map<String,dynamic>toMap(){
    return{
      'id':id,
      'nombre':nombre,
      'apellido1':apellido1,
      'apellido2':apellido2,
      'telefono': telefono,
      'correo': correo
    };
  }
}