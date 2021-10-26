
class NotasModel {
  int? id;
  String? titulo;
  String? detalle;

  NotasModel({this.id,this.titulo,this.detalle});

  //Map-> objetc
  factory NotasModel.fromMap(Map<String,dynamic> map){
    return NotasModel(
      id: map['id'],
      titulo: map['titulo'],
      detalle: map['detalle']
      
    );
  }
  //object->map
  Map<String,dynamic>toMap(){
    return{
      'id':id,
      'titulo':titulo,
      'detalle':detalle
    };
  }
}