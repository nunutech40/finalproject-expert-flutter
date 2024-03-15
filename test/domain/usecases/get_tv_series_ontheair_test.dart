import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_tvseries_ontheair.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTVSeriesOnTheAir usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTVSeriesOnTheAir(mockTvSeriesRepository);
  });

  final tMovies = <Movie>[];

  test('should get list of tv series on the air from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getTVSeriesOnTheAir())
        .thenAnswer((_) async => Right(tMovies));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tMovies));
  });
}
