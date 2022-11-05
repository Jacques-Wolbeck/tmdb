class GenreModel {
  int id;
  String name;

  GenreModel({required this.id, required this.name});

  factory GenreModel.fromJson(Map<String, dynamic> genre) {
    return GenreModel(id: genre['id'], name: genre['name']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  @override
  String toString() {
    return name;
  }
}
