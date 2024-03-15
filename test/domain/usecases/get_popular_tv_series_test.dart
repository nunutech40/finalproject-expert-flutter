import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTVSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetPopularTVSeries(mockTvSeriesRepository);
  });

  final tMovies = <Movie>[];

  group('GetPopular TV Series Tests', () {
    group('execute', () {
      test(
          'should get list of movies from the repository when execute function is called',
          () async {
        // arrange
        when(mockTvSeriesRepository.getPopularTVSeries())
            .thenAnswer((_) async => Right(tMovies));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tMovies));
      });
    });
  });
}
