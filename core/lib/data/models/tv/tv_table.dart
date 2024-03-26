import 'package:equatable/equatable.dart';
import 'package:tvshow/domain/entities/tv_show.dart';
import 'package:tvshow/domain/entities/tv_detail.dart';

class TvTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  const TvTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  factory TvTable.fromMap(Map<String, dynamic> map) => TvTable(
        id: map['id'],
        name: map['name'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'posterPath': posterPath,
      'overview': overview,
    };
  }

  factory TvTable.fromEntity(TvDetail tv) => TvTable(
      id: tv.id,
      name: tv.name,
      posterPath: tv.posterPath,
      overview: tv.overview);

  TvShow toEntity() => TvShow.watchlist(
      id: id, name: name, posterPath: posterPath, overview: overview);

  @override
  List<Object?> get props => [id, name, posterPath, overview];
}
