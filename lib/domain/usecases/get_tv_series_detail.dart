import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetTVSeriesDetail {
  final TvSeriesRepository repository;

  GetTVSeriesDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getTVSeriesDetail(id);
  }
}
