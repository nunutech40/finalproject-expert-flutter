import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_movies_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedMoviesBloc topRatedMoviesBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMoviesBloc = TopRatedMoviesBloc(mockGetTopRatedMovies);
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

  group('Test unit for Top Rated Movies Bloc', () {
    test(
      'Initial state should be empty',
      () => () {
        expect(topRatedMoviesBloc.state, TopRatedMoviesEmpty());
      },
    );

    blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return topRatedMoviesBloc;
      },
      act: (bloc) => bloc.add(TopRatedMoviesDidLoad()),
      expect: () => [
        TopRatedMoviesLoading(),
        TopRatedMoviesHasData(tMovieList),
      ],
      verify: (bloc) => {
        verify(mockGetTopRatedMovies.execute()),
      },
    );

    blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
      'Should emit [Loading, Error] when data is gotten unsuccessfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return topRatedMoviesBloc;
      },
      act: (bloc) => bloc.add(TopRatedMoviesDidLoad()),
      expect: () => [
        TopRatedMoviesLoading(),
        TopRatedMoviesError('Server Failure'),
      ],
      verify: (bloc) => {
        verify(mockGetTopRatedMovies.execute()),
      },
    );
  });
}
