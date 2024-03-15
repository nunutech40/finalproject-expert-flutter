import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_popular_tvseries.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvseries.dart';
import 'package:ditonton/domain/usecases/get_tvseries_ontheair.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_series_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_list_notifier_test.mocks.dart';

@GenerateMocks([GetTVSeriesOnTheAir, GetPopularTVSeries, GetTopRatedTVSeries])
void main() {
  late TVSeriesListNotifier provider;
  late MockGetTVSeriesOnTheAir mockGetTVSeriesOnTheAir;
  late MockGetPopularTVSeries mockGetPopularTVSeries;
  late MockGetTopRatedTVSeries mockGetTopRatedTVSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTVSeriesOnTheAir = MockGetTVSeriesOnTheAir();
    mockGetPopularTVSeries = MockGetPopularTVSeries();
    mockGetTopRatedTVSeries = MockGetTopRatedTVSeries();
    provider = TVSeriesListNotifier(
      getTVSeriesOnTheAir: mockGetTVSeriesOnTheAir,
      getPopularTVSeries: mockGetPopularTVSeries,
      getTopRatedTVSeries: mockGetTopRatedTVSeries,
    )..addListener(() {
        listenerCallCount += 1;
      });
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

  group('tv series on the air', () {
    test('initialState should be Empty', () {
      expect(provider.tvSeriesOnTheAirState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetTVSeriesOnTheAir.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      provider.fetchTVSeriesOnTheAir();
      // assert
      verify(mockGetTVSeriesOnTheAir.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetTVSeriesOnTheAir.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      provider.fetchTVSeriesOnTheAir();
      // assert
      expect(provider.tvSeriesOnTheAirState, RequestState.Loading);
    });

    test('should change tv series when data is gotten successfully', () async {
      // arrange
      when(mockGetTVSeriesOnTheAir.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      await provider.fetchTVSeriesOnTheAir();
      // assert
      expect(provider.tvSeriesOnTheAirState, RequestState.Loaded);
      expect(provider.tvSeriesOnTheAir, tMovieList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTVSeriesOnTheAir.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTVSeriesOnTheAir();
      // assert
      expect(provider.tvSeriesOnTheAirState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular tv series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularTVSeries.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      provider.fetchPopularTVSeries();
      // assert
      expect(provider.popularTVSeriesState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetPopularTVSeries.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      await provider.fetchPopularTVSeries();
      // assert
      expect(provider.popularTVSeriesState, RequestState.Loaded);
      expect(provider.popularTVSeries, tMovieList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTVSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTVSeries();
      // assert
      expect(provider.popularTVSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated tv series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedTVSeries.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      provider.fetchTopRatedTVSeries();
      // assert
      expect(provider.topRatedTVSeriesState, RequestState.Loading);
    });

    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTopRatedTVSeries.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      await provider.fetchTopRatedTVSeries();
      // assert
      expect(provider.topRatedTVSeriesState, RequestState.Loaded);
      expect(provider.topRatedTVSeries, tMovieList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTVSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTVSeries();
      // assert
      expect(provider.topRatedTVSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
