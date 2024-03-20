import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_movies_page_test.mocks.dart';

@GenerateMocks([TopRatedMoviesBloc])
void main() {
  late MockTopRatedMoviesBloc mockTopRatedMoviesBloc;

  setUp(() {
    mockTopRatedMoviesBloc = MockTopRatedMoviesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMoviesBloc>.value(
      value: mockTopRatedMoviesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Unit test fro testing group top rated movies', () {
    testWidgets('Page should display progress bar when loading',
        (WidgetTester tester) async {
      when(mockTopRatedMoviesBloc.state).thenReturn(
        TopRatedMoviesLoading(),
      );

      // Mock the stream of states the Bloc will emit
      when(mockTopRatedMoviesBloc.stream).thenAnswer(
        (_) => Stream.value(TopRatedMoviesLoading()),
      );

      final progressFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressFinder, findsOneWidget);
    });

    testWidgets('Page should display when data is loaded',
        (WidgetTester tester) async {
      when(mockTopRatedMoviesBloc.state)
          .thenReturn(TopRatedMoviesHasData(<Movie>[]));

      // Mock the stream of states the Bloc will emit
      when(mockTopRatedMoviesBloc.stream).thenAnswer(
        (_) => Stream.value(TopRatedMoviesLoading()),
      );

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(mockTopRatedMoviesBloc.state)
          .thenReturn(TopRatedMoviesError('Error message'));

      // Mock the stream of states the Bloc will emit
      when(mockTopRatedMoviesBloc.stream).thenAnswer(
        (_) => Stream.value(TopRatedMoviesLoading()),
      );

      final textFinder = find.byKey(Key('error_message_server'));

      await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}
