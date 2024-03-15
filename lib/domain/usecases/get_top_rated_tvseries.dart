import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetTopRatedTVSeries {
  final TvSeriesRepository repository;

  GetTopRatedTVSeries(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getTopRatedTVSeries();
  }
}
