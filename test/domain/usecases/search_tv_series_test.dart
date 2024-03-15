import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTVSeries usecase;
  late MockTvSeriesRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockTvSeriesRepository();
    usecase = SearchTVSeries(mockMovieRepository);
  });

  final tMovies = <Movie>[];
  final tQuery = 'Spiderman';

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockMovieRepository.searchTvSeries(tQuery))
        .thenAnswer((_) async => Right(tMovies));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tMovies));
  });
}
