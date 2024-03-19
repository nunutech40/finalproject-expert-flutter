import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvseries.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_series/top_rated_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../provider/tv_series_list_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedTVSeries])
void main() {
  late TopRatedTvSeriesBloc topRatedTvSeriesBloc;
  late MockGetTopRatedTVSeries mockGetTopRatedTVSeries;

  setUp(() {
    mockGetTopRatedTVSeries = MockGetTopRatedTVSeries();
    topRatedTvSeriesBloc = TopRatedTvSeriesBloc(mockGetTopRatedTVSeries);
  });

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

  group('Test unit for Top Rated Tv Series Bloc', () {
    test(
      'Initial state should be empty',
      () => () {
        expect(topRatedTvSeriesBloc.state, TopRatedTvSeriesEmpty());
      },
    );

    blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTVSeries.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return topRatedTvSeriesBloc;
      },
      act: (bloc) => bloc.add(TopRatedTvSeriesDidLoad()),
      expect: () => [
        TopRatedTvSeriesLoading(),
        TopRatedTvSeriesHasData(tMovieList),
      ],
      verify: (bloc) => {
        verify(mockGetTopRatedTVSeries.execute()),
      },
    );

    blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
      'Should emit [Loading, Error] when data is gotten unsuccessfully',
      build: () {
        when(mockGetTopRatedTVSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return topRatedTvSeriesBloc;
      },
      act: (bloc) => bloc.add(TopRatedTvSeriesDidLoad()),
      expect: () => [
        TopRatedTvSeriesLoading(),
        TopRatedTvSeriesError('Server Failure'),
      ],
      verify: (bloc) => {
        verify(mockGetTopRatedTVSeries.execute()),
      },
    );
  });
}
