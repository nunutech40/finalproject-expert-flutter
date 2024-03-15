import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTVSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTopRatedTVSeries(mockTvSeriesRepository);
  });

  final tMovies = <Movie>[];

  test('should get list of movies from repository', () async {
    // arrange
    when(mockTvSeriesRepository.getTopRatedTVSeries())
        .thenAnswer((_) async => Right(tMovies));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tMovies));
  });
}
