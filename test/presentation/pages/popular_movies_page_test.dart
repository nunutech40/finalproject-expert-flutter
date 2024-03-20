
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_movies_page_test.mocks.dart';

@GenerateMocks([PopularMoviesBloc])
void main() {
  late MockPopularMoviesBloc mockPopularMoviesBloc;

  setUp(() {
    mockPopularMoviesBloc = MockPopularMoviesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularMoviesBloc>.value(
      value: mockPopularMoviesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group(
    'Unit test for Popular Movies list page testing...',
    () {
      testWidgets('Page should display center progress bar when loading',
          (WidgetTester tester) async {
        when(mockPopularMoviesBloc.state).thenReturn(
          PopularMoviesLoading(),
        );

        // Mock the stream of states the Bloc will emit
        when(mockPopularMoviesBloc.stream).thenAnswer(
          (_) => Stream.value(PopularMoviesLoading()),
        );

        final progressFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

        expect(centerFinder, findsOneWidget);
        expect(progressFinder, findsOneWidget);
      });
      testWidgets('Page should display ListView when data is loaded',
          (WidgetTester tester) async {
        when(mockPopularMoviesBloc.state)
            .thenReturn(PopularMoviesHasData(<Movie>[]));

        // Mock the stream of states the Bloc will emit
        when(mockPopularMoviesBloc.stream).thenAnswer(
          (_) => Stream.value(PopularMoviesLoading()),
        );

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

        expect(listViewFinder, findsOneWidget);
      });

      testWidgets('Page should display text with message when Error',
          (WidgetTester tester) async {
        when(mockPopularMoviesBloc.state)
            .thenReturn(PopularMoviesError('Error message'));

        // Mock the stream of states the Bloc will emit
        when(mockPopularMoviesBloc.stream).thenAnswer(
          (_) => Stream.value(PopularMoviesLoading()),
        );

        final textFinder = find.byKey(Key('error_message_server'));

        await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

        expect(textFinder, findsOneWidget);
      });
    },
  );
}
