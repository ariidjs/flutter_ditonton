import 'package:equatable/equatable.dart';
import 'package:tvshow/domain/entities/genre.dart';

class GenreTvModel extends Equatable {
  const GenreTvModel({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory GenreTvModel.fromJson(Map<String, dynamic> json) => GenreTvModel(
        id: json["id"],
        name: json["name"],
      );

  Genre toEntity() {
    return Genre(id: id, name: name);
  }

  @override
  List<Object?> get props => [id, name];
}
