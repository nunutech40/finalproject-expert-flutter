import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_series/top_rated_tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_series_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_tv_series_page_test.mocks.dart';

@GenerateMocks([TopRatedTvSeriesBloc])
void main() {
  late MockTopRatedTvSeriesBloc mockTopRatedTvSeriesBloc;

  setUp(() {
    mockTopRatedTvSeriesBloc = MockTopRatedTvSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvSeriesBloc>.value(
      value: mockTopRatedTvSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Group unit test for top rated tv series', () {
    testWidgets('Page should display progress bar when loading',
        (WidgetTester tester) async {
      when(mockTopRatedTvSeriesBloc.state).thenReturn(
        TopRatedTvSeriesLoading(),
      );

      // Mock the stream of states the Bloc will emit
      when(mockTopRatedTvSeriesBloc.stream).thenAnswer(
        (_) => Stream.value(TopRatedTvSeriesLoading()),
      );

      final progressFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(TopRatedTVSeriesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressFinder, findsOneWidget);
    });

    testWidgets('Page should display when data is loaded',
        (WidgetTester tester) async {
      when(mockTopRatedTvSeriesBloc.state)
          .thenReturn(TopRatedTvSeriesHasData(<Movie>[]));

      // Mock the stream of states the Bloc will emit
      when(mockTopRatedTvSeriesBloc.stream).thenAnswer(
        (_) => Stream.value(TopRatedTvSeriesLoading()),
      );

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(TopRatedTVSeriesPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(mockTopRatedTvSeriesBloc.state)
          .thenReturn(TopRatedTvSeriesError('Error message'));

      // Mock the stream of states the Bloc will emit
      when(mockTopRatedTvSeriesBloc.stream).thenAnswer(
        (_) => Stream.value(TopRatedTvSeriesLoading()),
      );

      final textFinder = find.byKey(Key('error_message_server'));

      await tester.pumpWidget(_makeTestableWidget(TopRatedTVSeriesPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}
