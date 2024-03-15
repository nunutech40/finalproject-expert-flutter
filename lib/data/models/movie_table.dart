import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

class MovieTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;
  final String? name;

  MovieTable(
      {required this.id,
      required this.title,
      required this.posterPath,
      required this.overview,
      required this.name});

  factory MovieTable.fromEntity(MovieDetail movie) => MovieTable(
        id: movie.id,
        title: movie.title,
        name: movie.name,
        posterPath: movie.posterPath,
        overview: movie.overview,
      );

  factory MovieTable.fromMap(Map<String, dynamic> map) => MovieTable(
        id: map['id'],
        title: map['title'],
        name: map['name'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'name': name,
        'posterPath': posterPath,
        'overview': overview,
      };

  Movie toEntity() => Movie.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        title: title,
        name: name,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, name, posterPath, overview];
}
