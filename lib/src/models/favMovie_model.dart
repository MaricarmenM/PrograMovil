class FavMovieModel {
  int? id;
  String? title;
  String? backdropPath;

  FavMovieModel({
    this.id,
    this.title,
    this.backdropPath,
  });

  factory FavMovieModel.fromMap(Map<String, dynamic> map) {
    return FavMovieModel(
      id: map['id'],
      title: map['title'],
      backdropPath: map['backdrop_path'] ?? '',
    );
  }

  //Object -> Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'backdrop_path': backdropPath,
    };
  }

}