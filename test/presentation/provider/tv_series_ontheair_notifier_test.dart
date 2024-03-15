import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_tvseries_ontheair.dart';
import 'package:ditonton/presentation/provider/tv_series_onththeair.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_list_notifier_test.mocks.dart';

@GenerateMocks([GetTVSeriesOnTheAir])
void main() {
  late MockGetTVSeriesOnTheAir mockGetTVSeriesOnTheAir;
  late TVSeriesOnTheAirNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTVSeriesOnTheAir = MockGetTVSeriesOnTheAir();
    notifier = TVSeriesOnTheAirNotifier(mockGetTVSeriesOnTheAir)
      ..addListener(() {
        listenerCallCount++;
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

  group('TV Sereis on the air Notifier Test', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTVSeriesOnTheAir.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      notifier.fetchOnTheAirTVSeries();
      // assert
      expect(notifier.state, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test(
        'should change tv series on the air data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTVSeriesOnTheAir.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      await notifier.fetchOnTheAirTVSeries();
      // assert
      expect(notifier.state, RequestState.Loaded);
      expect(notifier.movies, tMovieList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTVSeriesOnTheAir.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await notifier.fetchOnTheAirTVSeries();
      // assert
      expect(notifier.state, RequestState.Error);
      expect(notifier.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
