import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/ontheair_tv_series/ontheair_tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/ontheair_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_ontheair_page_test.mocks.dart';

@GenerateMocks([OntheairTvSeriesBloc])
void main() {
  late MockOntheairTvSeriesBloc mockOntheairTvSeriesBloc;

  setUp(() {
    mockOntheairTvSeriesBloc = MockOntheairTvSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<OntheairTvSeriesBloc>.value(
      value: mockOntheairTvSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Unit test for tv series on thea air list page testing...', () {
    testWidgets('Page should display progress bar when loading',
        (WidgetTester tester) async {
      when(mockOntheairTvSeriesBloc.state).thenReturn(
        OntheairTvSeriesLoading(),
      );

      // Mock the stream of states the Bloc will emit
      when(mockOntheairTvSeriesBloc.stream).thenAnswer(
        (_) => Stream.value(OntheairTvSeriesLoading()),
      );

      final progressFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(OnTheAirTVSeriesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressFinder, findsOneWidget);
    });

    testWidgets('Page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(mockOntheairTvSeriesBloc.state)
          .thenReturn(OntheairTvSeriesHasData(<Movie>[]));

      // Mock the stream of states the Bloc will emit
      when(mockOntheairTvSeriesBloc.stream).thenAnswer(
        (_) => Stream.value(OntheairTvSeriesLoading()),
      );

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(OnTheAirTVSeriesPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(mockOntheairTvSeriesBloc.state)
          .thenReturn(OntheairTvSeriesError('Error message'));

      // Mock the stream of states the Bloc will emit
      when(mockOntheairTvSeriesBloc.stream).thenAnswer(
        (_) => Stream.value(OntheairTvSeriesLoading()),
      );

      final textFinder = find.byKey(Key('error_message_server'));

      await tester.pumpWidget(_makeTestableWidget(OnTheAirTVSeriesPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}
