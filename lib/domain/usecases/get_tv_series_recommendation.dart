import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetTVSeriesRecommendations {
  final TvSeriesRepository repository;

  GetTVSeriesRecommendations(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getTVSeriesRecommendations(id);
  }
}
