import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetTVSeriesOnTheAir {
  final TvSeriesRepository repository;

  GetTVSeriesOnTheAir(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getTVSeriesOnTheAir();
  }
}
