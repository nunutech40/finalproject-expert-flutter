import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/popular_tv_series/popular_tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/popular_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tv_series_page_test.mocks.dart';

@GenerateMocks([PopularTvSeriesBloc])
void main() {
  late MockPopularTvSeriesBloc mockPopularTvSeriesBloc;

  setUp(() {
    mockPopularTvSeriesBloc = MockPopularTvSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvSeriesBloc>.value(
      value: mockPopularTvSeriesBloc,
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
        when(mockPopularTvSeriesBloc.state).thenReturn(
          PopularTvSeriesLoading(),
        );

        // Mock the stream of states the Bloc will emit
        when(mockPopularTvSeriesBloc.stream).thenAnswer(
          (_) => Stream.value(PopularTvSeriesLoading()),
        );

        final progressFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        await tester.pumpWidget(_makeTestableWidget(PopularTVSeriesPage()));

        expect(centerFinder, findsOneWidget);
        expect(progressFinder, findsOneWidget);
      });
      testWidgets('Page should display ListView when data is loaded',
          (WidgetTester tester) async {
        when(mockPopularTvSeriesBloc.state)
            .thenReturn(PopularTvSeriesHasData(<Movie>[]));

        // Mock the stream of states the Bloc will emit
        when(mockPopularTvSeriesBloc.stream).thenAnswer(
          (_) => Stream.value(PopularTvSeriesLoading()),
        );

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(PopularTVSeriesPage()));

        expect(listViewFinder, findsOneWidget);
      });

      testWidgets('Page should display text with message when Error',
          (WidgetTester tester) async {
        when(mockPopularTvSeriesBloc.state)
            .thenReturn(PopularTvSeriesError('Error message'));

        // Mock the stream of states the Bloc will emit
        when(mockPopularTvSeriesBloc.stream).thenAnswer(
          (_) => Stream.value(PopularTvSeriesLoading()),
        );

        final textFinder = find.byKey(Key('error_message_server'));

        await tester.pumpWidget(_makeTestableWidget(PopularTVSeriesPage()));

        expect(textFinder, findsOneWidget);
      });
    },
  );
}
