import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_tvseries.dart';
import 'package:ditonton/presentation/bloc/popular_tv_series/popular_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../provider/tv_series_list_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTVSeries])
void main() {
  late PopularTvSeriesBloc popularTvSeriesBloc;
  late MockGetPopularTVSeries mockGetPopularTVSeries;

  setUp(
    () {
      mockGetPopularTVSeries = MockGetPopularTVSeries();
      popularTvSeriesBloc = PopularTvSeriesBloc(mockGetPopularTVSeries);
    },
  );

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    name: 'name',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieList = <Movie>[tMovie];

  group('Test unit for popular movies grup', () {
    test(
      'Initial state should be empty',
      () => () {
        expect(popularTvSeriesBloc.state, PopularTvSeriesEmpty());
      },
    );

    blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetPopularTVSeries.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return popularTvSeriesBloc;
      },
      act: (bloc) => bloc.add(PopularTvSeriesDidLoad()),
      expect: () => [
        PopularTvSeriesLoading(),
        PopularTvSeriesHasData(tMovieList),
      ],
      verify: (bloc) => {
        verify(mockGetPopularTVSeries.execute()),
      },
    );

    blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
      'Should emit [Loading, Error] when data is gotten unsuccessfully',
      build: () {
        when(mockGetPopularTVSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return popularTvSeriesBloc;
      },
      act: (bloc) => bloc.add(PopularTvSeriesDidLoad()),
      expect: () => [
        PopularTvSeriesLoading(),
        PopularTvSeriesError('Server Failure'),
      ],
      verify: (bloc) => {
        verify(mockGetPopularTVSeries.execute()),
      },
    );
  });
}
