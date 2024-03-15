import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:ditonton/data/models/movie_model.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesRepositoryImpl repository;
  late MockTvSeriesRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvSeriesRemoteDataSource();
    repository = TvSeriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
    );
  });

  final tMovieModel = MovieModel(
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
    name: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tMovie = Movie(
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
    name: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tMovieModelList = <MovieModel>[tMovieModel];
  final tMovieList = <Movie>[tMovie];

  group('TV Series On The Air', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVSeriesOnTheAir())
          .thenAnswer((_) async => tMovieModelList);
      // act
      final result = await repository.getTVSeriesOnTheAir();
      // assert
      verify(mockRemoteDataSource.getTVSeriesOnTheAir());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVSeriesOnTheAir())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTVSeriesOnTheAir();
      // assert
      verify(mockRemoteDataSource.getTVSeriesOnTheAir());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVSeriesOnTheAir())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTVSeriesOnTheAir();
      // assert
      verify(mockRemoteDataSource.getTVSeriesOnTheAir());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular TV Series', () {
    test('should return movie list when call to data source is success',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTVSeries())
          .thenAnswer((_) async => tMovieModelList);
      // act
      final result = await repository.getPopularTVSeries();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTVSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getPopularTVSeries();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTVSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTVSeries();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated TV Series', () {
    test('should return movie list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTVSeries())
          .thenAnswer((_) async => tMovieModelList);
      // act
      final result = await repository.getTopRatedTVSeries();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTVSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTVSeries();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTVSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTVSeries();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get TV Series Detail', () {
    final tId = 1;
    final tMovieResponse = MovieDetailResponse(
      adult: false,
      backdropPath: 'backdropPath',
      budget: 100,
      genres: [GenreModel(id: 1, name: 'Action')],
      homepage: "https://google.com",
      id: 1,
      imdbId: 'imdb1',
      originalLanguage: 'en',
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      revenue: 12000,
      runtime: 120,
      status: 'Status',
      tagline: 'Tagline',
      title: 'title',
      name: 'name',
      video: false,
      voteAverage: 1,
      voteCount: 1,
    );

    test(
        'should return Movie data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVSeriesDetail(tId))
          .thenAnswer((_) async => tMovieResponse);
      // act
      final result = await repository.getTVSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTVSeriesDetail(tId));
      expect(result, equals(Right(testMovieDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVSeriesDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTVSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTVSeriesDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVSeriesDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTVSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTVSeriesDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get TV Series Recommendations', () {
    final tMovieList = <MovieModel>[];
    final tId = 1;

    test('should return data (movie list) when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVSeriesRecommendations(tId))
          .thenAnswer((_) async => tMovieList);
      // act
      final result = await repository.getTVSeriesRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTVSeriesRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tMovieList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVSeriesRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTVSeriesRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getTVSeriesRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVSeriesRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTVSeriesRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTVSeriesRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Seach TV Series', () {
    final tQuery = 'spiderman';

    test('should return tv series list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvSeries(tQuery))
          .thenAnswer((_) async => tMovieModelList);
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvSeries(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvSeries(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });
}
