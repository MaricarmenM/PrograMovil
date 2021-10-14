class TareasModel {
  int? id;
  String? nomTarea;
  String? descTarea;
  String? fechaEntrega;
  String? entregada;

  TareasModel({this.id,this.nomTarea,this.descTarea,this.fechaEntrega,this.entregada});

  //Map-> objetct
  factory TareasModel.fromMap(Map<String,dynamic> map){
    return TareasModel(
      id: map['id'],
      nomTarea: map['nomTarea'],
      descTarea: map['descTarea'],
      fechaEntrega: map['fechaEntrega'],
      entregada: map['entregada'],
    );
  }
  //object->map
  Map<String,dynamic>toMap(){
    return{
      'id':id,
      'nomTarea':nomTarea,
      'descTarea':descTarea,
      'fechaEntrega':fechaEntrega,
      'entregada':entregada,
    };
  }
}