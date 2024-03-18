import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/now_playing_movie/now_playing_movie_bloc.dart';
import 'package:ditonton/presentation/pages/now_palying_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'now_playing_page_test.mocks.dart';

@GenerateMocks([NowPlayingMovieBloc])
void main() {
  late MockNowPlayingMovieBloc mockNowPlayingMovieBloc;

  setUp(() {
    mockNowPlayingMovieBloc = MockNowPlayingMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<NowPlayingMovieBloc>.value(
      value: mockNowPlayingMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Unit test for now playing list page testing...', () {
    testWidgets('Page should display CircularProgressIndicator when loading',
        (WidgetTester tester) async {
      when(mockNowPlayingMovieBloc.state).thenReturn(
        NowPlayingMovieLoading(),
      );

      // Mock the stream of states the Bloc will emit
      when(mockNowPlayingMovieBloc.stream).thenAnswer(
        (_) => Stream.value(NowPlayingMovieLoading()),
      );

      final progressFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(NowPlayingPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressFinder, findsOneWidget);
    });

    testWidgets('Page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(mockNowPlayingMovieBloc.state)
          .thenReturn(NowPlayingMovieHasData(<Movie>[]));

      // Mock the stream of states the Bloc will emit
      when(mockNowPlayingMovieBloc.stream).thenAnswer(
        (_) => Stream.value(NowPlayingMovieLoading()),
      );

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(NowPlayingPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(mockNowPlayingMovieBloc.state)
          .thenReturn(NowPlayingMovieError('Error message'));

      // Mock the stream of states the Bloc will emit
      when(mockNowPlayingMovieBloc.stream).thenAnswer(
        (_) => Stream.value(NowPlayingMovieLoading()),
      );

      final textFinder = find.byKey(Key('error_message_server'));

      await tester.pumpWidget(_makeTestableWidget(NowPlayingPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}
