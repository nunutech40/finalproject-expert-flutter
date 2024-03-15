import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class SearchTVSeries {
  final TvSeriesRepository repository;

  SearchTVSeries(this.repository);

  Future<Either<Failure, List<Movie>>> execute(String query) {
    return repository.searchTvSeries(query);
  }
}
