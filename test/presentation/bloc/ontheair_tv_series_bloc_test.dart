import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_tvseries_ontheair.dart';
import 'package:ditonton/presentation/bloc/ontheair_tv_series/ontheair_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'ontheair_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetTVSeriesOnTheAir])
void main() {
  late OntheairTvSeriesBloc ontheairTvSeriesBloc;
  late MockGetTVSeriesOnTheAir mockGetTVSeriesOnTheAir;

  setUp(() {
    mockGetTVSeriesOnTheAir = MockGetTVSeriesOnTheAir();
    ontheairTvSeriesBloc = OntheairTvSeriesBloc(mockGetTVSeriesOnTheAir);
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

  group('Group Testing Unit for TV Series On The Air Bloc', () {
    test('Initial state should be empty', () {
      expect(ontheairTvSeriesBloc.state, OntheairTvSeriesEmpty());
    });

    blocTest<OntheairTvSeriesBloc, OntheairTvSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTVSeriesOnTheAir.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return ontheairTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OntheairTvSeriesDidLoad()),
      expect: () => [
        OntheairTvSeriesLoading(),
        OntheairTvSeriesHasData(tMovieList),
      ],
      verify: (bloc) => {
        verify(mockGetTVSeriesOnTheAir.execute()),
      },
    );

    blocTest<OntheairTvSeriesBloc, OntheairTvSeriesState>(
      'Should emit [Loading, Error] when data is gotten unsuccessfully',
      build: () {
        when(mockGetTVSeriesOnTheAir.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return ontheairTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OntheairTvSeriesDidLoad()),
      expect: () => [
        OntheairTvSeriesLoading(),
        OntheairTvSeriesError('Server Failure'),
      ],
      verify: (bloc) => {
        verify(mockGetTVSeriesOnTheAir.execute()),
      },
    );
  });
}
