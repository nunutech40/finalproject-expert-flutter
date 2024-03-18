import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:ditonton/presentation/bloc/search_tv_series/search_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_tv_series_bloc_test.mocks.dart';

@GenerateMocks([SearchTVSeries])
void main() {
  late SearchTvSeriesBloc searcTvSeriesBloc;
  late MockSearchTVSeries mockSearchTVSeries;

  setUp(() {
    mockSearchTVSeries = MockSearchTVSeries();
    searcTvSeriesBloc = SearchTvSeriesBloc(mockSearchTVSeries);
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
    name: 'Spider-Man',
  );
  final tMovieList = <Movie>[tMovieModel];
  final tQuery = 'spiderman';

  group('Unit test for testing search tv series bloc', () {
    test('Initial state should be empty', () {
      expect(searcTvSeriesBloc.state, SearchTvSeriesEmpty());
    });

    blocTest(
      'Should emit [Loading, HashData] when data is gotten successfully ',
      build: () {
        when(mockSearchTVSeries.execute(tQuery))
            .thenAnswer((_) async => Right(tMovieList));
        return searcTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnQueryChangeEvent(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => {
        SearchTvSeriesLoading(),
        SearchTvSeriesHasdata(tMovieList),
      },
      verify: (bloc) => {
        verify(
          mockSearchTVSeries.execute(tQuery),
        ),
      },
    );

    blocTest(
      'Should emit [Loading, SearchTvSeriesError] when data is gotten failed or unsuccessfull',
      build: () {
        when(mockSearchTVSeries.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
        return searcTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnQueryChangeEvent(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchTvSeriesLoading(),
        SearchTvSeriesError("Server Failure"),
      ],
      verify: (bloc) => {
        verify(
          mockSearchTVSeries.execute(tQuery),
        )
      },
    );
  });
}
