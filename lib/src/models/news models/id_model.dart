
class NewsSourceModel {
  String? id;
  String? name;

  NewsSourceModel({
    this.id,
    this.name,
  });

    factory NewsSourceModel.fromJson(Map<String,dynamic> json){
    return NewsSourceModel(
      id    : json['id'],
      name  : json['name'], 
    );
  }



}
