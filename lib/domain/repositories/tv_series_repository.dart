import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/common/failure.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<Movie>>> getTVSeriesOnTheAir();
  Future<Either<Failure, List<Movie>>> getPopularTVSeries();
  Future<Either<Failure, List<Movie>>> getTopRatedTVSeries();
  Future<Either<Failure, MovieDetail>> getTVSeriesDetail(int id);
  Future<Either<Failure, List<Movie>>> getTVSeriesRecommendations(int id);
  Future<Either<Failure, List<Movie>>> searchTvSeries(String query);
}
